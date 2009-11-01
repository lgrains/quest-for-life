class LitType < ActiveHash::Base
  field :name
  
  self.data = [
    {:id => 1, :name => 'Science Fiction/Fantasy'},
    {:id => 2, :name => 'Religious'},
    {:id => 3, :name => 'Classics'},
    {:id => 4, :name => 'Crime Drama/Mysteries'},
    {:id => 5, :name => 'History'},
    {:id => 6, :name => 'Science'},
    {:id => 7, :name => 'Self-help'},
    {:id => 8, :name => 'Business'},
    {:id => 9, :name => 'Drama/Fiction'},
    {:id => 10, :name => 'Biography'}
  ]
  
  def self.sorted
    @@sorted_data ||= all.sort_by{|x| x.name}
    return @@sorted_data
  end
end