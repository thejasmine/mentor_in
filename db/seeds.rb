Review.destroy_all
Appointment.destroy_all
Event.destroy_all
User.destroy_all

test_user = User.create!(email: "test@gmail.com",
                         password: "123456",
                         name: "Val",
                         content:Faker::Lorem.paragraph(sentence_count: 2),
                         description: Faker::Lorem.paragraph(sentence_count: 1),
                         user_type: "Mentor",
                         expertise: "Business Development",
                         about_me: Faker::Lorem.paragraph(sentence_count: 2)
                         )

puts "Creating Users…"
3.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 8),
    name: Faker::TvShows::TheExpanse.character,
    content: Faker::Lorem.paragraph(sentence_count: 2),
    user_type:["Mentor","Student","Company"].sample,
    description: Faker::Lorem.paragraph(sentence_count: 2),
    expertise: Faker::IndustrySegments.industry,
    about_me: Faker::Lorem.paragraph(sentence_count: 2)
  )

  puts "Creating Events..."
  rand(2..4).times do
    event = Event.create!(
      name: Faker::Lorem.word,
      description: Faker::Lorem.paragraph(sentence_count: 2),
      category: ['Education','Technology','Business'].sample,
      level: ['Easy','Hard','Median'].sample,
      link: Faker::Internet.url(host: 'example.com'),
      start_time: Faker::Time.forward(days: 23, period: :morning),
      end_time: Faker::Time.forward(days: 23, period: :morning),
      capacity: rand(20..100),
      user: user
    )
  end
  puts "Creating Appointments..."
  rand(1..3).times do
    appointment = Appointment.create!(
      date: Faker::Date.forward(days: rand(1..3)),
      finished_at: Faker::Date.forward(days: rand(4..8)),
      event: Event.all.sample,
      requester: User.all.sample,
    )
    puts "Creating Reviews....."
    rand(1..3).times do
      review = Review.create!(
        title:Faker::GreekPhilosophers.quote,
        content:Faker::Lorem.sentence(word_count: 14, supplemental: true),
        appointment: appointment,
        rating: rand(1..5),
      )
    end
  end
end


test_event = Event.all.sample
test_event.user = test_user
test_event.save

rand(1..3).times do
  appointment = Appointment.create!(
    date: Faker::Date.forward(days: rand(1..3)),
    finished_at: Faker::Date.forward(days: rand(4..8)),
    event: test_event,
    requester: User.all.sample,
  )
  puts "Creating Reviews....."
  rand(1..2).times do
    review = Review.create!(
      title:Faker::GreekPhilosophers.quote,
      content:Faker::Lorem.sentence(word_count: 14, supplemental: true),
      appointment: appointment,
      rating: rand(1..5),
    )
  end
end

puts 'Finished!'
