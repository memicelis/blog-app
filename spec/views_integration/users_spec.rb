require 'rails_helper'

RSpec.describe User, type: :system do
    subject { User.new(name: 'User1', photo: 'https://avatars.githubusercontent.com/u/7747059?v=4', posts_counter: 6, bio: 'Full-stack web developer') }

    before { subject.save }

  it 'I can see the username, profile picture, and post count for each user on user#index page' do
    visit users_path

    expect(page).to have_content(subject.name)
    expect(page).to have_css("img[src*='#{subject.photo}']")
    expect(page).to have_content(subject.posts_counter)

  end

  it 'When I click on user, it opens its page' do
    visit users_path

    click_link 'User1'

    expect(page).to have_current_path(user_path(subject))
  end

  it 'On user#show, I can see user\'s profile picture,username,number of posts,bio,first 3 posts, button that lets me view all posts' do

   Post.create([
      { author: subject, title: 'First Post', text: 'My first post' },
      { author: subject, title: 'Second Post', text: 'My Second post' },
      { author: subject, title: 'Third Post', text: 'My Third post' },
      { author: subject, title: 'Fourth Post', text: 'My Fourth post' }]) 

    visit user_path(subject)
    expect(page).to have_css("img[src*='#{subject.photo}']")
    expect(page).to have_content(subject.name)
    expect(page).to have_content(subject.posts_counter)
    expect(page).to have_content(subject.bio)
    recent_posts_titles = subject.recent_posts.pluck(:title)

    recent_posts_titles.each do |post_title|
      expect(page).to have_content(post_title)
    end
    expect(page).to have_link('See all posts')
  end

  it 'On user#show click a user\'s post, it redirects me to that post\'s show page.' do
    post = Post.create(
      { author: subject, title: 'First Post', text: 'My first post' })
    visit user_path(subject)
    click_link 'First Post'
    expect(page).to have_current_path(user_post_path(subject,post))
  end

  it 'On user#show click to see all posts, it redirects me to user\'s post\'s index page.' do
    visit user_path(subject)
    click_link 'See all posts'
    expect(page).to have_current_path(user_posts_path(subject))
  end
end