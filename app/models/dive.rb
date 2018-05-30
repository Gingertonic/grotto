class Dive < ActiveRecord::Base
  validates :date, presence: true
  validates_format_of :date, :with => /\d{2}\/\d{2}\/\d{4}/
  belongs_to :user
  belongs_to :divesite

  def self.missing_date?(params)
    params[:dive][:date].empty?
  end

  def self.valid_date?(params)
    e = (params[:dive][:date]).split("/")
    d = e.first
    m = e.second
    y = e.third
    thirties = [9, 4, 7, 11]
    if d.to_i > 29 && m.to_i == 2
      false
    elsif d.to_i > 30 && thirties.include?(m.to_i)
      false
    elsif d.to_i > 31 || d.to_i < 1
      false
    elsif m.to_i > 12
      false
    else
      true
    end
  end

  def self.incorrect_date_format?(params)
    !params[:dive][:date].match(/\d{2}\/\d{2}\/\d{4}/)
  end

  def self.missing_params?(params)
    !params[:dive][:divesite_id] && (!params[:new_site] || (params[:new_site][:name].empty? || params[:new_site][:location].empty? || params[:new_site][:country].empty?))
  end

  def self.with_new_divesite?(params)
    (!params[:dive][:divesite_id] || params[:dive][:divesite_id].empty?)
  end

  def create_and_add_divesite(params, divesite)
    new_dive = current_user.dives.create(params)
    new_dive.update(divesite: divesite)
  end

  def map_source
    "https://www.google.com/maps/embed/v1/search?key=AIzaSyCTvz6Gwbc_XUccsnJHBBGaLEn_IbZvWIY&q=#{self.divesite.location}+#{self.divesite.country}&zoom=13"
  end

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

    if d.match(/^1./)
      date = "#{d}th"
    elsif d.match(/1$/)
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


  def slug
    date.split("/").join("-")
  end

  def self.find_by_slug(slug)
    result = Dive.all.select {|dive| dive.slug == slug}
    result.first
  end

  def self.find_by_user_divesite_and_date(params)
    result = Dive.all.select {|dive| dive.user.slug == params[:user] && dive.divesite.slug == "#{params[:country].downcase}/#{params[:location].downcase}/#{params[:name].downcase}" && dive.slug == params[:date]}
    result.first
  end
end
