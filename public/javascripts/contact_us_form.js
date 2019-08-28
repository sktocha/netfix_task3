var ContactUsForm,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

ContactUsForm = (function() {
  function ContactUsForm() {
    this.markFieldAsInvalid = bind(this.markFieldAsInvalid, this);
    this.form = $('#main_form');
    this.initHandlers();
  }

  ContactUsForm.prototype.initHandlers = function() {
    this.form.bind('submit', (function(_this) {
      return function(e) {
        var data;
        e.preventDefault();
        data = new FormData(_this.form.get(0));
        _this.disableForm();
        if (window.environment === 'test') {
          return _this.submitForm(data);
        } else {
          return grecaptcha.ready(function() {
            return grecaptcha.execute(window.captcha_site_key, {
              action: 'create_comment'
            }).then(function(token) {
              data.set('g-recaptcha-response', token);
              return _this.submitForm(data);
            });
          });
        }
      };
    })(this));
    return this.form.find('#send_more').bind('click', (function(_this) {
      return function(e) {
        e.preventDefault();
        _this.form.find('#success').hide();
        return _this.form.find('fieldset').show();
      };
    })(this));
  };

  ContactUsForm.prototype.submitForm = function(data) {
    return $.post({
      url: this.form.attr('action'),
      data: data,
      processData: false,
      contentType: false
    }).done((function(_this) {
      return function(xhr, data) {
        _this.form.find('#success').show();
        _this.form.find('fieldset').hide();
        return _this.resetForm();
      };
    })(this)).fail((function(_this) {
      return function(xhr) {
        _this.markAllFieldsAsSuccess();
        return $.each(xhr.responseJSON, function(k, v) {
          return _this.markFieldAsInvalid(k, v);
        });
      };
    })(this)).always((function(_this) {
      return function(xhr) {
        return _this.enableForm();
      };
    })(this));
  };

  ContactUsForm.prototype.resetForm = function() {
    this.form.trigger('reset');
    this.markAllFieldsAsSuccess();
    return this.form.find('input, label, textarea').removeClass('is-valid text-success');
  };

  ContactUsForm.prototype.markAllFieldsAsSuccess = function() {
    this.form.find('input,textarea').removeClass('is-invalid').addClass('is-valid');
    this.form.find('label').removeClass('text-danger').addClass('text-success');
    return this.form.find('small[id$="_error"]').text('');
  };

  ContactUsForm.prototype.markFieldAsInvalid = function(field_id, error) {
    this.form.find("#email_message_" + field_id).removeClass('is-valid').addClass('is-invalid');
    this.form.find("label[for=email_message_" + field_id + "]").removeClass('text-success').addClass('text-danger');
    return this.form.find("#email_message_" + field_id + "_error").text(error);
  };

  ContactUsForm.prototype.enableForm = function() {
    return this.form.find('fieldset').removeAttr('disabled');
  };

  ContactUsForm.prototype.disableForm = function() {
    return this.form.find('fieldset').attr('disabled', '1');
  };

  return ContactUsForm;

})();

$(function() {
  return window.main_form = new ContactUsForm();
});
