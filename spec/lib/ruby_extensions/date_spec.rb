require "spec_helper"

describe Date do
  it "compare_time" do
    past, now, future = [1999, 12, 31, 11, 59, 59], [2000, 1, 1, 0, 0, 0], [2000, 1, 1, 0, 0, 1]
    Date.new(*now[0, 2]).compare_time(Time.utc(*past)).should eql 1
    Date.new(*now[0, 2]).compare_time(Time.utc(*now)).should eql 0
    Date.new(*now[0, 2]).compare_time(Time.utc(*future)).should eql -1
    Date.new(*now[0, 2]).compare_time(DateTime.civil(*past)).should eql 1
    Date.new(*now[0, 2]).compare_time(DateTime.civil(*now)).should eql 0
    Date.new(*now[0, 2]).compare_time(DateTime.civil(*future)).should eql -1
    Date.new(*now[0, 2]).compare_time(Date.new(1999, 12, 31)).should eql 1
    Date.new(*now[0, 2]).compare_time(Date.new(2000, 1, 1)).should eql 0
    Date.new(*now[0, 2]).compare_time(Date.new(2000, 1, 2)).should eql -1
  end

  it "before?" do
    past, now, future = [1999, 12, 31, 11, 59, 59], [2000, 1, 1, 0, 0, 0], [2000, 1, 1, 0, 0, 1]
    Date.new(*now[0, 2]).before?(Time.utc(*past)).should be_false
    Date.new(*now[0, 2]).before?(Time.utc(*now)).should be_false
    Date.new(*now[0, 2]).before?(Time.utc(*future)).should be_true
  end

  it "after?" do
    past, now, future = [1999, 12, 31, 11, 59, 59], [2000, 1, 1, 0, 0, 0], [2000, 1, 1, 0, 0, 1]
    Date.new(*now[0, 2]).after?(Time.utc(*past)).should be_true
    Date.new(*now[0, 2]).after?(Time.utc(*now)).should be_false
    Date.new(*now[0, 2]).after?(Time.utc(*future)).should be_false
  end

  it "same_time?" do
    past, now, future = [1999, 12, 31, 11, 59, 59], [2000, 1, 1, 0, 0, 0], [2000, 1, 1, 0, 0, 1]
    Date.new(*now[0, 2]).same_time?(Time.utc(*past)).should be_false
    Date.new(*now[0, 2]).same_time?(Time.utc(*now)).should be_true
    Date.new(*now[0, 2]).same_time?(Time.utc(*future)).should be_false
  end

  it "same_time_or_before?" do
    past, now, future = [1999, 12, 31, 11, 59, 59], [2000, 1, 1, 0, 0, 0], [2000, 1, 1, 0, 0, 1]
    Date.new(*now[0, 2]).same_time_or_before?(Time.utc(*past)).should be_false
    Date.new(*now[0, 2]).same_time_or_before?(Time.utc(*now)).should be_true
    Date.new(*now[0, 2]).same_time_or_before?(Time.utc(*future)).should be_true
  end

  it "same_time_or_after?" do
    past, now, future = [1999, 12, 31, 11, 59, 59], [2000, 1, 1, 0, 0, 0], [2000, 1, 1, 0, 0, 1]
    Date.new(*now[0, 2]).same_time_or_after?(Time.utc(*past)).should be_true
    Date.new(*now[0, 2]).same_time_or_after?(Time.utc(*now)).should be_true
    Date.new(*now[0, 2]).same_time_or_after?(Time.utc(*future)).should be_false
  end

  it "within?" do
    past, now, future = [1999, 12, 31, 11, 59, 59], [2000, 1, 1, 0, 0, 0], [2000, 1, 1, 0, 0, 1]
    Date.new(*now[0..2]).within?(Time.utc(*past), Time.utc(*future)).should be_true
    Date.new(*past[0..2]).within?(Time.utc(*past), Time.utc(*future)).should be_false
    Date.new(*future[0..2]).within?(Time.utc(*past), Time.utc(*future)).should be_true
    Date.new(*future[0..2]).within?(Time.utc(*past), Time.utc(*future), true).should be_true
    Date.new(*future[0..2]).within?(Time.utc(*past), DateTime.civil(*future)).should be_true
    Date.new(*future[0..2]).within?(Time.utc(*past), DateTime.civil(*future), true).should be_true
    Date.new(*future[0..2]).within?(Time.utc(*past), Date.new(*future[0..2])).should be_true
    Date.new(*future[0..2]).within?(Time.utc(*past), Date.new(*future[0..2]), true).should be_false
    Date.new(*past[0..2]).within?(Time.utc(*now), Time.utc(*future)).should be_false
    Date.new(*future[0..2]).within?(Time.utc(*past), Time.utc(*now)).should be_true
  end

  it "outside?" do
    past, now, future = [1999, 12, 31, 11, 59, 59], [2000, 1, 1, 0, 0, 0], [2000, 1, 1, 0, 0, 1]
    Date.new(*now[0..2]).outside?(Time.utc(*past), Time.utc(*future)).should be_false
    Date.new(*past[0..2]).outside?(Time.utc(*past), Time.utc(*future)).should be_true
    Date.new(*future[0..2]).outside?(Time.utc(*past), Time.utc(*future)).should be_false
    Date.new(*future[0..2]).outside?(Time.utc(*past), Time.utc(*future), true).should be_false
    Date.new(*past[0..2]).outside?(Time.utc(*now), Time.utc(*future)).should be_true
    Date.new(*future[0..2]).outside?(Time.utc(*past), Time.utc(*now)).should be_false
  end
end