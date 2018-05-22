class Dive < ActiveRecord::Base
  validates :date, presence: true
  belongs_to :user
  belongs_to :divesite

  def full_date
    e = date.split("/")
    d = e.first
    m = e.second
    y = e.third
    case m
    when "01"
      month = "January"
    when "02"
      month = "February"
    when "03"
      month = "March"
    when "04"
      month = "April"
    when "05"
      month = "May"
    when "06"
      month = "June"
    when "07"
      month = "July"
    when "08"
      month = "August"
    when "09"
      month = "September"
    when "10"
      month = "October"
    when "11"
      month = "November"
    when "12"
      month = "December"
    end

    d = d[1...2] if d.match(/^0/)


    if d.match(/1$/)
      date = "#{d}st"
    elsif d.match(/2$/)
      date = "#{d}nd"
    elsif d.match(/3$/)
      date = "#{d}rd"
    elsif d.match(/[4567890]$/)
      date = "#{d}th"
    end

    full_date = "#{month} the #{date}, #{y}"
  end
end
