# frozen_string_literal: true

require_relative 'train.rb'
require_relative 'passengertrain.rb'
require_relative 'cargotrain.rb'
require_relative 'route.rb'
require_relative 'station.rb'
require_relative 'railcar.rb'
require_relative 'passengercar.rb'
require_relative 'cargocar.rb'
require_relative 'creator.rb'

master = Creator.new

loop do
  puts "\nTo create entities type 0 \nTo interact with entities type 1 \nTo list entities type 2"
  puts 'To finish, type exit'
  case gets.chomp
  when '0'
    loop do
      puts "\nTo create a train, type 'train <type>', types are 'passenger' and 'cargo'"
      puts "To create a station, type 'station <name>'"
      puts "To create a route, type 'route <station_id> <station_id>'"
      puts "To go back, type 'back'\n"
      input = gets.chomp.split
      case input[0]
      when 'train'
        master.create_train! input[1]
      when 'station'
        master.create_station! input[1]
      when 'route'
        master.create_route! input[1], input[2]
      when 'back'
        break
      else
        puts 'Input is invalid'
      end
    end
  when '1'
    loop do
      puts "\nTo add railcars to a train, type 'car add <type> <id>'\nType and ID belong to a train"
      puts "To remove railcars from a train, type 'car remove <type> <id>'\nType and ID belong to a train"
      puts "To add stations to a route, type 'route add <route_id> <station_id>"
      puts "To remove stations from a route, type 'route remove <route_id> <route_station_id>'"
      puts "To move a train, type 'train move <type> <train_id> <direction>, directions are forwards and backwards'"
      puts "To assign a route to a train, type 'train assign <type> <train_id> <route_id>"
      puts "To go back, type 'back'\n"
      input = gets.chomp.split
      case input[0]
      when 'car'
        case input[1]
        when 'add'
          master.add_car! input[2], input[3]
        when 'remove'
          master.remove_car! input[2], input[3]
        else
          puts 'Invalid command!'
        end
      when 'route'
        case input[1]
        when 'add'
          master.add_to_route! input[2], input[3]
        when 'remove'
          master.remove_from_route! input[2], input[3]
        else
          puts 'Invalid command!'
        end
      when 'train'
        case input[1]
        when 'move'
          master.move! input[2], input[3], input[4]
        when 'assign'
          master.set_train_route! input[2], input[3], input[4]
        else
          puts 'Invalid command!'
        end
      when 'back'
        break
      else
        puts 'Invalid command!'
      end
    end
  when '2'
    loop do
      puts "\nTo list trains, type 'trains <type>', types are 'passenger' and 'cargo"
      puts "To list stations, type 'stations'"
      puts "To list routes, type 'routes'\n"
      puts "To go back, type 'back'"
      input = gets.chomp.split
      case input[0]
      when 'trains'
        master.list_trains input[1]
      when 'stations'
        master.list_stations
      when 'routes'
        master.list_routes
      when 'back'
        break
      else
        puts 'Invalid command'
      end
    end
  when 'exit'
    break
  else
    puts 'Input is invalid'
  end
end
