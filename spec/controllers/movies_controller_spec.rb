require 'spec_helper'

describe MoviesController do
  describe 'Find Movies With Same Director' do
    before :each do
      @fake_results = [mock('movie1'), mock('movie2')]
    end
    it 'should call find movies by director' do
      Movie.should_receive(:find_movies_by_director).with('1').
          and_return(@fake_results)
      get :similar, {:id => '1'}
    end
  end
end