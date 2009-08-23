class AddAgeGroups < ActiveRecord::Migration
  def self.up
    execute "update surveys set age_group_id=null;"
    AgeGroup.destroy_all
    AgeGroup.create! :description => '11 and under', :position => 1
    AgeGroup.create! :description => '12 - 14', :position => 2
    AgeGroup.create! :description => '15 - 18', :position => 3
    AgeGroup.create! :description => '19 - 25', :position => 4
    AgeGroup.create! :description => '26-35', :position => 5
    AgeGroup.create! :description => '36 - 50', :position => 6
    AgeGroup.create! :description => '50+', :position => 7
  end

  def self.down
    AgeGroup.destroy_all
  end
end
