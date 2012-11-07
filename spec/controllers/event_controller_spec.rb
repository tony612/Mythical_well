require 'spec_helper'

describe EventsController do
  let :attrs do {title: 'Test title', category: 'life', start_date: Time.now, end_date: Time.now, location: 'center', content: 'Test content', fee: '0'}
end
