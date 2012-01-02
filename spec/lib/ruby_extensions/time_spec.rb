require "spec_helper"

describe Time do
  it "before?" do
    past, now, future = [1999, 12, 31, 11, 59, 59], [2000, 1, 1, 0, 0, 0], [2000, 1, 1, 0, 0, 1]
    Time.utc(*now).before?(Time.utc(*past)).should be_false
    Time.utc(*now).before?(Time.utc(*now)).should be_false
    Time.utc(*now).before?(Time.utc(*future)).should be_true
  end

  it "after?" do
    past, now, future = [1999, 12, 31, 11, 59, 59], [2000, 1, 1, 0, 0, 0], [2000, 1, 1, 0, 0, 1]
    Time.utc(*now).after?(Time.utc(*past)).should be_true
    Time.utc(*now).after?(Time.utc(*now)).should be_false
    Time.utc(*now).after?(Time.utc(*future)).should be_false
  end

  it "same_time?" do
    past, now, future = [1999, 12, 31, 11, 59, 59], [2000, 1, 1, 0, 0, 0], [2000, 1, 1, 0, 0, 1]
    Time.utc(*now).same_time?(Time.utc(*past)).should be_false
    Time.utc(*now).same_time?(Time.utc(*now)).should be_true
    Time.utc(*now).same_time?(Time.utc(*future)).should be_false
  end

  it "same_time_or_before?" do
    past, now, future = [1999, 12, 31, 11, 59, 59], [2000, 1, 1, 0, 0, 0], [2000, 1, 1, 0, 0, 1]
    Time.utc(*now).same_time_or_before?(Time.utc(*past)).should be_false
    Time.utc(*now).same_time_or_before?(Time.utc(*now)).should be_true
    Time.utc(*now).same_time_or_before?(Time.utc(*future)).should be_true
  end

  it "same_time_or_after?" do
    past, now, future = [1999, 12, 31, 11, 59, 59], [2000, 1, 1, 0, 0, 0], [2000, 1, 1, 0, 0, 1]
    Time.utc(*now).same_time_or_after?(Time.utc(*past)).should be_true
    Time.utc(*now).same_time_or_after?(Time.utc(*now)).should be_true
    Time.utc(*now).same_time_or_after?(Time.utc(*future)).should be_false
  end

  it "within?" do
    past, now, future = [1999, 12, 31, 11, 59, 59], [2000, 1, 1, 0, 0, 0], [2000, 1, 1, 0, 0, 1]
    Time.utc(*now).within?(Time.utc(*past), Time.utc(*future)).should be_true
    Time.utc(*past).within?(Time.utc(*past), Time.utc(*future)).should be_true
    Time.utc(*future).within?(Time.utc(*past), Time.utc(*future)).should be_true
    Time.utc(*future).within?(Time.utc(*past), Time.utc(*future), true).should be_false
    Time.utc(*future).within?(Time.utc(*past), DateTime.civil(*future)).should be_true
    Time.utc(*future).within?(Time.utc(*past), DateTime.civil(*future), true).should be_false
    Time.utc(2000, 1, 1, 0, 0, 0).within?(Time.utc(*past), Date.new(*future[0..2])).should be_true
    Time.utc(2000, 1, 1, 0, 0, 0).within?(Time.utc(*past), Date.new(*future[0..2]), true).should be_false
    Time.utc(*past).within?(Time.utc(*now), Time.utc(*future)).should be_false
    Time.utc(*future).within?(Time.utc(*past), Time.utc(*now)).should be_false
  end

  it "outside?" do
    past, now, future = [1999, 12, 31, 11, 59, 59], [2000, 1, 1, 0, 0, 0], [2000, 1, 1, 0, 0, 1]
    Time.utc(*now).outside?(Time.utc(*past), Time.utc(*future)).should be_false
    Time.utc(*past).outside?(Time.utc(*past), Time.utc(*future)).should be_false
    Time.utc(*future).outside?(Time.utc(*past), Time.utc(*future)).should be_false
    Time.utc(*future).outside?(Time.utc(*past), Time.utc(*future), true).should be_true
    Time.utc(*past).outside?(Time.utc(*now), Time.utc(*future)).should be_true
    Time.utc(*future).outside?(Time.utc(*past), Time.utc(*now)).should be_true
  end
end