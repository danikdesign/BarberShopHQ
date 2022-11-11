#encoding: utf-8

require 'rubygems'
require 'sinatra'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "barbershop.db"}

before do
  @barbers = Barber.order 'created_at DESC'
end

class Client < ActiveRecord::Base
  validates :name, presence: true
  validates :phone, presence: true
  validates :datestamp, presence: true
  validates :color, presence: true
end

class Barber < ActiveRecord::Base
end

class Contact < ActiveRecord::Base
end

get '/' do
  erb :index
end


get '/visit' do
  erb :visit
end

post '/visit' do
  c = Client.new params[:client]
  c.save

  @title = 'Вы успешно записались. До встречи!'
  @content = "Вы записаны к нам в BarberShop #{@datestamp} к мастеру: #{@barber}. Вы выбрали цвет окрашивания #{@color}"
  erb :message
end

get '/contacts' do
  erb :contacts
end

post '/contacts' do
  @email = params[:email]
  @message = params[:message]

  Contact.create(email: @email, message: @message)

  @title = 'Спасибо!'
  @content = 'Мы получили ваше обращение. Мы обязательно свяжемся с вами, позже'
  erb :message

end
