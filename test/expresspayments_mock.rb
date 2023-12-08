# frozen_string_literal: true

module ExpressPayments
  class ExpressPaymentsMock
    include Singleton

    PATH_SPEC = "#{::File.dirname(__FILE__)}/openapi/spec3.json"
    PATH_FIXTURES = "#{::File.dirname(__FILE__)}/openapi/fixtures3.json"

    @pid = nil
    @port = -1

    # Starts expresspayments-mock, if necessary. Returns the port on which expresspayments-mock is listening.
    def self.start
      unless ::File.exist?(PATH_SPEC)
        port = ENV["EP_MOCK_PORT"] || 12_111
        puts("No custom spec file found, assuming expresspayments-mock is already running on port #{port}")
        return port
      end

      unless @pid.nil?
        puts("expresspayments-mock already running on port #{@port}")
        return @port
      end

      puts("Starting expresspayments-mock...")

      @stdout, @child_stdout = ::IO.pipe
      @stderr, @child_stderr = ::IO.pipe

      @pid = ::Process.spawn(
        %w[expresspayments-mock expresspayments-mock],
        "-http-port",
        "0", # have expresspayments-mock select a port
        "-spec",
        PATH_SPEC,
        "-fixtures",
        PATH_FIXTURES,
        out: @child_stdout,
        err: @child_stderr
      )

      [@child_stdout, @child_stderr].each(&:close)

      # Look for port in "Listening for HTTP on port: 50602"
      buffer = ""
      loop do
        buffer += @stdout.readpartial(4096)
        if (matches = buffer.match(/ port: (\d+)/))
          @port = matches[1]
          break
        end
        sleep(0.1)
      end

      status = (::Process.wait2(@pid, ::Process::WNOHANG) || []).last
      if status.nil?
        puts("Started expresspayments-mock; PID = #{@pid}, port = #{@port}")
      else
        abort("expresspayments-mock terminated early: #{status}")
      end

      @port
    end

    # Stops expresspayments-mock, if necessary.
    def self.stop
      return if @pid.nil?

      puts("Stopping expresspayments-mock...")
      ::Process.kill(:SIGTERM, @pid)
      ::Process.waitpid2(@pid)
      @pid = nil
      @port = -1
      puts("Stopped expresspayments-mock")
    end
  end
end
