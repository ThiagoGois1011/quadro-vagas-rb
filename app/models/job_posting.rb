class JobPosting < ApplicationRecord
  include PgSearch::Model
  pg_search_scope :search_jobs,
                  against:  [ :title, :description ],
                  using: {
                    trigram: {
                      word_similarity: true
                    }
                  }

  belongs_to :company_profile
  belongs_to :job_type
  enum :status, { active: 0, archived: 2 }, optional: :active
  validates :title, :salary, :salary_currency, :salary_period, :company_profile, :job_type, :description, presence: true

  def self.translated_status(symbol)
    I18n.t("activerecord.attributes.job_posting.status.#{symbol}")
  end
end
