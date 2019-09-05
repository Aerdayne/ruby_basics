class Station
    attr_reader :name

    def initialize(name)
        @name = name
        @trains = []
    end

    def host(train)
        @trains << train if train.current == self
    end
    
    def depart(train)
        @trains.delete(train) if train.current == self
    end

    def list
        @trains.each { |train| print(train) }
    end

    def list_passenger
        list = @trains.select { |train| train.type == 'passenger' }
        list.each { |train| print(train) }
    end

    def list_freight
        list = @trains.select { |train| train.type == 'freight' }
        list.each { |train| print(train) }
    end
end

class Route
    attr_reader :departure, :destination, :intermediate

    def initialize(departure,destination)
        @departure = departure
        @destination = destination
        @intermediate = []
    end

    def add_intermediate(station)
        @intermediate << station
    end

    def remove_intermediate(station)
        @intermediate.delete(station)
    end
    
    def list_route
        print(@departure)
        @intermediate.each { |station| print(station) }
        print(@destination)
    end
end

class Train
    attr_reader :speed
    attr_reader :car_quantity
    attr_reader :type
    attr_reader :current

    def initialize(id,type,car_quantity)
        @id = id
        @type = type
        @car_quantity = car_quantity
        @speed = 0
    end

    def speedup
        @speed += 10
    end

    def slowdown
        @speed -= 10
    end

    def couple
        @speed == 0 ? @car_quantity += 1 : puts("Train is in motion")
    end

    def decouple
        @speed == 0 ? @car_quantity -= 1 : puts("Train is in motion")
    end

    def set_route(route)
        @route = route
        @route_whole = [@route.departure, @route.intermediate, @route.destination].flatten
        @current = @route_whole[0]
    end

    def forwards
        index = @route_whole.index(@current)
        if index.nil? || @route_whole[index + 1] == nil
            puts('Train has reached destination') 
        else
            @current = @route_whole[index + 1]
        end
    end

    def backwards
        index = @route_whole.index(@current)
        if index.nil? || @route_whole[index - 1] == nil || index == 0
            puts('Train has reached destination')
        else 
            @current = @route_whole[index - 1]
        end
    end

    def list
        index = @route_whole.index(@current)
        print('Current - ' + @route_whole[index].name)
        if index != 0
            print('Previous - ' + @route_whole[index - 1].name)
        end
        if @route_whole[index + 1] != nil
            print('Next - ' + @route_whole[index + 1].name)
        end
    end
end