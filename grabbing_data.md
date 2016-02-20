todo add sources options to crystal ball like grocery and simple food
add in interventions
also make it easier to enter many foods at once
also add undo adding food

install spellcheck in sublime


Time of Day Data:
===================
24.times do |i|
  ratings = Dump.all.select do |d|
    d.created_at.in_time_zone("Central Time (US & Canada)").hour >= i &&
    d.created_at.in_time_zone("Central Time (US & Canada)").hour < i+1
  end.map(&:rating)
  average = (ratings.sum.to_f/ratings.count)
  average = average.round(2)
  puts "From #{i}-#{i+1} hr: #{average}"
end

Day of Week Data:
===================
days = {
  0 => 'Sunday',
  1 => 'Monday',
  2 => 'Tuesday',
  3 => 'Wednesday',
  4 => 'Thursday',
  5 => 'Friday',
  6 => 'Saturday'
}
7.times do |i|
  ratings = Dump.all.select do |d|
    d.created_at.in_time_zone("Central Time (US & Canada)").wday == i
  end.map(&:rating)
  average = (ratings.sum.to_f/ratings.count)
  average = average.round(2)
  puts "#{days[i]}: #{average}"
end

Day of Month Data:
===================
dump_days = Dump.all.order(:created_at).group_by {|dump| dump.created_at.to_date }
dump_days.each do |day, ratings|
  ratings = ratings.map(&:rating)
  average = (ratings.sum.to_f/ratings.count)
  average = average.round(2)
  puts "#{day.month}/#{day.day}: #{average}"
end; nil


Worst Foods Data:
==================

consistent_ingredients = Ingredient.all.select do |ingredient|
  ratings = ingredient.ratings.map(&:rating)
  ratings.count > 3 && ratings.stdev < 1
end
consistent_ingredients.map! do |ingredient|
  ratings = ingredient.ratings.map(&:rating)
  {
    name: ingredient.name,
    average_rating: (ratings.sum.to_f/ratings.count).round(2),
    ratings_count: ratings.count
  }
end
consistent_ingredients.sort_by!{|ingred| ingred[:average_rating] }
consistent_ingredients.each do |ingred|
  puts "#{ingred[:name]}: #{ingred[:average_rating]} (#{ingred[:ratings_count]})"
end; nil

