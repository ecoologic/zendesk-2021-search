class Models::User
  def initialize(record)
    @record = record
  end

  # ars = associated_records
  def decorated_record(ars)
    record
      .merge(organization_name:
        ars[:organizations].find { |r| r[:_id] == record[:organization_id] }[:name]) # [record[:organization_id]].first[:name]) # TODO: to_h[:name] || N_A
      .merge(assigned_ticket_subjects:
        ars[:tickets].select { |t| t[:assignee_id] == record[:_id] }.map { |t| t[:subject] })
  end

  def association_rules
    {
      organizations: { _id: record[:organization_id] },
      tickets: { submitter_id: record[:_id], assignee_id: record[:_id] }
    }
  end

  private

  attr_reader :record
end