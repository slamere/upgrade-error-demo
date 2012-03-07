class Organization < ActiveRecord::Base

  has_many :activities, :dependent => :destroy
  has_many :phones, :dependent => :destroy
  accepts_nested_attributes_for :phones, :allow_destroy => true

  # Virtual attributes to store association changes
  attr_accessor :phones_changes
  attr_accessor :phones_added

  before_save :store_association_dirty_attributes

  # Store certain associations' dirty attributes for reference by this object
  # later (such as in an observer).
  def store_association_dirty_attributes
    # store phone changes
    self.phones_changes = {}
    # FIXME: One solution to a rails 2.3.6 problem with association changes not saving is to comment out this whole loop
    for phone in self.phones
      if phone.new_record?
        self.phones_added ||= []
        self.phones_added << phone
      elsif phone.changed?
        # populate phones_changes attribute as a hash indexed by the phone id
        self.phones_changes[phone.id] = phone.changes
      end
    end
  end
end
