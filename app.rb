#encoding: utf-8

require 'rubygems'
require 'sinatra'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "barbershop.db"}

before do
  @barbers = Barber.order 'created_at DESC'
end

class Client < ActiveRecord::Base
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
  @username = params[:username]
  @phone = params[:phone]
  @datestamp = params[:datestamp]
  @barber = params[:barber]
  @color = params[:color]

  Client.create(name: @username, phone: @phone, datestamp: @datestamp, barber: @barber, color: @color)

  @title = 'Вы успешно записались. До встречи!'
  @message = "Вы записаны к нам в BarberShop #{@datestamp} к мастеру: #{@barber}. Вы выбрали цвет окрашивания #{@color}"
  erb :message
end
