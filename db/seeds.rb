# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'ffaker'

def sample_text
  (1..10).map{|i|"<p>#{Faker::HTMLIpsum.fancy_string}</p>"}.join
end

def random_date
  start = Date.today.prev_year(2)
  final = Date.today.next_month(3)
  (start..final).select {|d| (1..5).include?(d.wday)}
end

def random_hour_9to3(date)
  (date + rand(9..15).hour + rand(0..60).minutes).to_datetime
end

range = 7.times.map { random_date.map { |d| random_hour_9to3(d)}}.flatten

15.times do
  Physician.new.tap do |u|
    u.name = Faker::Name.name
    u.save!
  end
end

350.times do
  Patient.new.tap do |q|
    q.name = Faker::Name.name
    q.email = Faker::Internet.email
    q.phone = Faker::PhoneNumber.short_phone_number
    q.save!
  end
end

range.each do |d|
  Appointment.new.tap do |a|
    a.patient = Patient.order( 'RANDOM()' ).first
    a.physician = Physician.order( 'RANDOM()' ).first
    a.datetime = d
    a.notes = Faker::HipsterIpsum.sentence(15)
    a.save!
  end
end
