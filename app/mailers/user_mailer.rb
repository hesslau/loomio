class UserMailer < ActionMailer::Base
  include ApplicationHelper
  default :from => "\"Loomio\" <noreply@loom.io>"

  def daily_activity(user, activity, since_time)
    @user = user
    @activity = activity
    @since_time = since_time
    @groups = user.groups
    mail to: @user.email,
         subject: 'Loomio - Daily activity summary'
  end

  def group_membership_approved(user, group)
    @user = user
    @group = group
    mail( :to => user.email,
          :reply_to => @group.admin_email,
          :subject => "#{email_subject_prefix(@group.full_name)} Membership approved")
  end

  def motion_closing_soon(user, motion)
    @user = user
    @motion = motion
    mail to: user.email,
         subject: "[Loomio - #{@motion.group.name}] Proposal closing soon: #{@motion.name}"
  end

  def added_to_group(user, group)
    @user = user
    @group = group
    mail( :to => user.email,
          :reply_to => @group.admin_email,
          :subject => "[Loomio] You've been added to a group called '#{@group.full_name}'")
  end

  # Invited to loomio (assumes user has been invited to a group at the same time)
  def invited_to_loomio(new_user, inviter, group)
    @new_user = new_user
    @inviter = inviter
    @group = group
    mail( :to => new_user.email,
          :reply_to => inviter.email,
          :subject => "#{inviter.name} has invited you to #{group.full_name} on Loomio")
  end
end
