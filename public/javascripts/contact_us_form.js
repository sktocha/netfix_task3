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
          _this.submitForm(data);
        } else {
          return grecaptcha.ready(function() {
            return grecaptcha.execute(window.captcha_site_key, {
              action: 'create_comment'
            }).then(function(token) {
              data.set('g-recaptcha-response', token);
              _this.submitForm(data);
            });
          });
        }
      };
    })(this));
    this.form.find('#send_more').bind('click', (function(_this) {
      return function(e) {
        e.preventDefault();
        _this.form.find('#success').hide();
        _this.form.find('fieldset').show();
      };
    })(this));
  };

  ContactUsForm.prototype.submitForm = function(data) {
    $.post({
      url: this.form.attr('action'),
      data: data,
      processData: false,
      contentType: false
    }).done((function(_this) {
      return function(xhr, data) {
        _this.form.find('#success').show();
        _this.form.find('fieldset').hide();
        _this.resetForm();
      };
    })(this)).fail((function(_this) {
      return function(xhr) {
        _this.markAllFieldsAsSuccess();
        $.each(xhr.responseJSON, function(k, v) {
          _this.markFieldAsInvalid(k, v);
        });
      };
    })(this)).always((function(_this) {
      return function(xhr) {
        _this.enableForm();
      };
    })(this));
  };

  ContactUsForm.prototype.resetForm = function() {
    this.form.trigger('reset');
    this.markAllFieldsAsSuccess();
    this.form.find('input, label, textarea').removeClass('is-valid text-success');
  };

  ContactUsForm.prototype.markAllFieldsAsSuccess = function() {
    this.form.find('input,textarea').removeClass('is-invalid').addClass('is-valid');
    this.form.find('label').removeClass('text-danger').addClass('text-success');
    this.form.find('small[id$="_error"]').text('');
  };

  ContactUsForm.prototype.markFieldAsInvalid = function(field_id, error) {
    this.form.find("#email_message_" + field_id).removeClass('is-valid').addClass('is-invalid');
    this.form.find("label[for=email_message_" + field_id + "]").removeClass('text-success').addClass('text-danger');
    this.form.find("#email_message_" + field_id + "_error").text(error);
  };

  ContactUsForm.prototype.enableForm = function() {
    this.form.find('fieldset').removeAttr('disabled');
  };

  ContactUsForm.prototype.disableForm = function() {
    this.form.find('fieldset').attr('disabled', '1');
  };

  return ContactUsForm;

})();

$(function() {
  window.main_form = new ContactUsForm();
});


// original(coffeescript)

// class ContactUsForm
//   constructor: ->
//     @form = $('#main_form')
//     @initHandlers()
//   initHandlers: ->

//     @form.bind 'submit', (e) =>
//       e.preventDefault()
//       data = new FormData(@form.get(0))
//       @disableForm()
//       if window.environment == 'test'
//         @submitForm(data)
//       else
//         grecaptcha.ready =>
//           grecaptcha.execute(window.captcha_site_key, {action: 'create_comment'}).then (token) =>
//             data.set('g-recaptcha-response', token)
//             @submitForm(data)

//     @form.find('#send_more').bind 'click', (e) =>
//       e.preventDefault()
//       @form.find('#success').hide()
//       @form.find('fieldset').show()

//   submitForm: (data) ->
//     $.post(url: @form.attr('action'), data: data, processData: false, contentType: false)
//       .done (xhr, data) =>
//         @form.find('#success').show()
//         @form.find('fieldset').hide()
//         @resetForm()
//     .fail (xhr) =>
//       @markAllFieldsAsSuccess()
//       $.each xhr.responseJSON, (k, v) =>
//         @markFieldAsInvalid(k, v)
//     .always (xhr) =>
//       @enableForm()
//   resetForm: ->
//     @form.trigger('reset')
//     @markAllFieldsAsSuccess()
//     @form.find('input, label, textarea').removeClass('is-valid text-success')
//   markAllFieldsAsSuccess: ->
//     @form.find('input,textarea').removeClass('is-invalid').addClass('is-valid')
//     @form.find('label').removeClass('text-danger').addClass('text-success')
//     @form.find('small[id$="_error"]').text('')
//   markFieldAsInvalid: (field_id, error) =>
//      @form.find("#email_message_#{field_id}").removeClass('is-valid').addClass('is-invalid')
//      @form.find("label[for=email_message_#{field_id}]").removeClass('text-success').addClass('text-danger')
//      @form.find("#email_message_#{field_id}_error").text(error)
//   enableForm: ->
//     @form.find('fieldset').removeAttr('disabled')
//   disableForm: ->
//     @form.find('fieldset').attr('disabled', '1')
// $ -> window.main_form = new ContactUsForm()
