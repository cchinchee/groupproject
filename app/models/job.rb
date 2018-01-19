class Job < ApplicationRecord
    belongs_to :user
    belongs_to :affiliate, optional: true
end
