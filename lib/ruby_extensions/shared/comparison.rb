require 'date'

module RubyExtensions
  module Shared
    # Comparisons
    #
    # Provides for chronological comparisons between Time, Date and DateTime objects using before?, after? same_time?,
    # same_time_or_before?, same_time_or_after?, within?, outside? and compare_time methods.
    #
    # This provides a more readable alternative the <, >, <=, >=, == and <=> methods for time comparison, and allows for
    # comparing a Time with a Date/DateTime (the built-in methods return an ArgumentError in this case.)
    #
    # Examples:
    #
    #  past      = Time.utc(2007, 6, 7, 4, 30, 29)
    #  present   = Time.utc(2007, 6, 7, 4, 30, 30)
    #  future    = Time.utc(2007, 6, 7, 4, 30, 31)
    #
    #  present.same_time? DateTime.civil(2007, 6, 7, 4, 30, 30)  # => true
    #  past.before? present  # => true
    #  past.same_time_or_before? present  # => true
    #  past.after? present  # => false
    #  past.after? Date.new(2012,1,1)  # => true
    #  past.same_time_or_after? present  # => false
    #  present.within? past, future  # => true
    #  present.outside? past, future  # => false
    #
    #  times = [present, future, past, Date.new(1990), DateTime.civil(2012)]
    #  puts times.sort {|a,b| a.compare_time(b)}  # =>
    #  1990-01-01
    #  Fri Jun 08 16:30:29 UTC 2007
    #  Fri Jun 08 16:30:30 UTC 2007
    #  Fri Jun 08 16:30:31 UTC 2007
    #  2012-01-01T00:00:00+00:00
    #
    # Note that Date objects are considered as a time point at the beginning of the day.
    # Therefore the following will be true:
    #
    #  Time.now.after? Date.today # => true
    #
    # Copyright (c) 2007 Geoff Buesing
    #
    module Comparison
      # Returns true if receiver is chronologically before a Time, Date or DateTime object
      def before? other
        self.compare_time(other) == -1
      end

      # Returns true if receiver is chronologically after a Time, Date or DateTime object
      def after? other
        self.compare_time(other) == 1
      end

      # Returns true if receiver is chronologically equal to a Time, Date or DateTime object
      def same_time? other
        self.compare_time(other) == 0
      end

      # Returns true if receiver is chronologically equal to or before a Time, Date or DateTime object
      def same_time_or_before? other
        result = self.compare_time(other)
        result == -1 || result == 0
      end

      # Returns true if receiver is chronologically equal to or after a Time, Date or DateTime object
      def same_time_or_after? other
        result = self.compare_time(other)
        result == 1 || result == 0
      end

      # Returns true if receiver is chronologically equal to or after start, and equal to or before end
      # (or before and not equal to end if final argument is set to true)
      # Arguments can be Time, Date or DateTime objects
      def within? first, last, exclusive=false
        end_method = exclusive ? 'before?' : 'same_time_or_before?'
        self.same_time_or_after?(first) && self.__send__(end_method, last)
      end

      # Returns opposite of within? method
      def outside? first, last, exclusive=false
        !self.within?(first, last, exclusive)
      end

      # Allows chronological comparisons between Time, Date and DateTime objects. Returns -1, 0 or 1, like <=> operator
      def compare_time other
        case other
          when ::Time
            ::Time === self ? self <=> other : self <=> DateTime.parse(other.to_s)
          when ::Date
            ::Date === self ? self <=> other : DateTime.parse(self.to_s) <=> other
          else
            raise ArgumentError, "can't compare #{self.class} with #{other.class}"
        end
      end
    end
  end
end
