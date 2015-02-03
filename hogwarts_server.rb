require 'pry'
require 'sinatra'
require 'json'

students = {
	0 => {
		id:0, 
		name: "Harry",
		age: "13",
		favspell: "Avada Kedarva",
		house: "none"
	}
}
counter = 1

get '/' do
	erb :index, locals: {students: students}
end

get '/students' do
	erb :index, locals: {students: students}
end

post '/student' do
	newstudent = {
		id: counter,
		name: params["name"],
		age: params["age"],
		favspell: params["favspell"],
		house: "none"
	}
	students[counter] = newstudent
	counter += 1
	redirect '/students'
end

get '/student/:id' do
	thisstudent = students[params[:id].to_i]
	erb :show, locals: {thisstudent: thisstudent}
end

put '/student/:id' do
	student=students[params[:id].to_i]
	student[:name] = params["newname"]
	redirect '/students'
end

delete '/student/:id' do
	students.delete(params[:id].to_i)
	redirect "/students"
end

get '/search' do
	erb :search, locals: {students: students}
end

post '/search' do
	searchkey = params[:name].upcase.gsub(" ", "")
	match = false
	students.each do |key, student|
		if (student[:name].upcase.gsub(" ", "") == searchkey)
			match = true
			matchkey = key
		end
	end
	if match == true
		redirect '/student/:matchkey'
	else
		redirect '/fail'
	end
end

get '/fail' do
	erb :fail
end