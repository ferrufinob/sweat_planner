puts "users"
User.create(name: "Brenda", email: "ferruf@ferruf.com", password: "password")
puts "user created"

puts "workout"
Workout.create(day_of_week: "Monday", target_area: "Glutes", activity:"hip thrusts 2x15, squats 2x20, donkey kicks 2x20", duration: "30 minutes", user_id: 1)