class Affiliate < ApplicationRecord
	has_secure_password
	has_many :jobs
	has_many :training_courses
	enum verification_status: { Unverified: false, Verified: true}
	serialize :verification_documents, Array
	mount_uploaders :verification_documents, VerificationDocumentsUploader
	mount_uploader :affiliates_avatar, VerificationDocumentsUploader
end
