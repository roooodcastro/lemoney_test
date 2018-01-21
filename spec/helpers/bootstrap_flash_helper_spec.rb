# frozen_string_literal: true

RSpec.describe BootstrapFlashHelper do
  describe '#bootstrap_flash' do
    subject { helper.bootstrap_flash }

    context 'When there is a :notice flash' do
      before(:each) { helper.flash[:notice] = 'Notice flash' }

      it 'should return a success alert' do
        is_expected.to have_tag(:div, with: { class: 'alert alert-success' }) do
          with_tag(:button)
          with_tag(:span) { with_text 'Notice flash' }
        end
      end
    end

    context 'When there is a :alert flash' do
      before(:each) { helper.flash[:alert] = 'Alert flash' }

      it 'should return a warning alert' do
        is_expected.to have_tag(:div, with: { class: 'alert alert-warning' }) do
          with_tag(:button)
          with_tag(:span) { with_text 'Alert flash' }
        end
      end
    end

    context 'When there is a :error flash' do
      before(:each) { helper.flash[:error] = 'Error flash' }

      it 'should return a danger alert' do
        is_expected.to have_tag(:div, with: { class: 'alert alert-danger' }) do
          with_tag(:button)
          with_tag(:span) { with_text 'Error flash' }
        end
      end
    end
  end
end
