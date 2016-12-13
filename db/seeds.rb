# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
user = User.create(email:"angelmendezz751@gmail.com",name:"Angel Mendez",uid:"ajnsj12sdjn" , provider: "facebook")
poll = MyPoll.create(user:user,title:"Voy a crear una red social y este es un negocio multimillonario :v #{SecureRandom.hex}" , description:"Estudio de mercado :v" , expires_at: DateTime.now + 1.month)
question = Question.create(my_poll:poll,description:"Algo pa la encuesta :V")
answer = Answer.create(question:question,description:"La neta no se :v")
