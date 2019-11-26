# frozen_string_literal: true

module CategoryEnum
  extend ActiveSupport::Concern
  included do |klass|
    enum category: {
      vegetables: 0,
      fruits: 1,
      automotive: 2,
      animals: 3,
      antiques: 4,
      real_estate: 5,
      food: 6,
      electronics: 7,
      clothing: 8
    }, _prefix: klass.name.downcase
  end
end
