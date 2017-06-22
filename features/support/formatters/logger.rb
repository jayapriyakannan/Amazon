module Loggers
  class BaseLogger
    def self.results
      @@results
    end

    def self.init_results
      @@results           = {}
      @@results[:fatal]   = []
      @@results[:error]   = []
      @@results[:warn] = []
      @@results[:info]    = []
      @@results[:all]     = []
    end

    def self.timestamp
      ts = Time.now #- TEST_RUN_START
      formatted_timestamp = ts.strftime("%b %e %H:%M:%S") # "%i:%02i" % [ts.to_i/60,(ts%60).round]
      formatted_timestamp
    end

    def self.prefix_with_timestamp(name)
      "#{timestamp} #{name}"
    end

    def self.append_timestamp_to(name)
      "#{name} [#{timestamp}]"
    end

    def self.add_result(type, result_name)
      @@results[type] << append_timestamp_to(result_name)
      @@results[:all] << prefix_with_timestamp("(#{type.to_s.upcase}) #{result_name}")
    end

    def self.close
      init_results
      @logdev.close if @logdev
    end

    init_results

    def self.log(_severity, _text, _options)
      raise NotImplementedError, "You should define self.log in your custom logger"
    end

    def self.debug(text, options = {})
      add_result(:info, text)
      log(:debug, text, options)
    end

    def self.info(text, options = {})
      add_result(:info, text)
      log(:info, text, options)
    end

    def self.warn(text, options = {})
      add_result(:warn, text)
      log(:warn, text, options)
    end

    def self.error(text, options = {})
      add_result(:error, text)
      log(:error, text, options)
    end

    def self.fatal(text, options = {})
      add_result(:fatal, text)
      log(:fatal, text, options)
    end
  end

  class CliLogger < BaseLogger
    def self.silent?
      !!@silent
    end

    def self.silent=(val)
      @silent = val
    end

    def self.log(status, message, _options)
      unless silent? && [:debug, :info, :warn].include?(status)
        puts "#{status.to_s.upcase}: #{message}"
      end
    end
  end
end
