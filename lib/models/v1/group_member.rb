require 'sequel'

class Models::V1::GroupMember < Sequel::Model(:group_member)
  many_to_many :message,
    join_table: :msg_group,
    left_key: :ROWID,
    left_primary_key: :group_id,
    right_key: :ROWID,
    right_primary_key: :group_id
end