class CleanupOldBlankGenders < ActiveRecord::Migration
  def self.up
    execute "update surveys set gender = null where gender = '';"
  end

  def self.down
  end
end
