people = ['Armandina Bylsma', 'Blanch Prior', 'Claud Ulery', 'Doug Basler', 'Delina Motley', 'Gina Ruis', 'Salome Maples']

SCHEDULER.every '3s' do
  leaderboard = Array.new

  people.each do |person, i|
    leaderboard << {label: person, value: i}
  end

  send_event('leaderboard', { items: leaderboard })
end