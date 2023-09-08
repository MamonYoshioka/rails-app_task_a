class Relationship < ApplicationRecord
  # フォローしたユーザー => follower
  # フォローされたユーザー => followed
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end
