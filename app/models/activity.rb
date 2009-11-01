class Activity < ActiveHash::Base
  field :name
  
  self.data = [
    {:id => 1, :name => 'Reading'},
    {:id => 2, :name => 'Sports'},
    {:id => 3, :name => 'Social Activities (Parties, Hanging out with friends)'},
    {:id => 4, :name => 'Music (Listening or Playing)'},
    {:id => 5, :name => 'Outdoors (Hiking, Canoeing)'},
    {:id => 6, :name => 'Arts & Crafts (Painting, Writing, Knitting, etc.)'},
    {:id => 7, :name => 'Religious Activities'},
    {:id => 8, :name => 'Academics (School, Learning)'},
    {:id => 9, :name => 'Movies'},
    {:id => 10, :name => 'Video Games'}
  ]
  
  def self.sorted
    @@sorted_data = all.sort_by{|x| x.name}
    return @@sorted_data
  end
end