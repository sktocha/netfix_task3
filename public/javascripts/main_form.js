var MainForm,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

MainForm = (function() {
  function MainForm() {
    this.markFieldAsInvalid = bind(this.markFieldAsInvalid, this);
    this.form = $('#main_form');
    this.initHandlers();
  }

  MainForm.prototype.initHandlers = function() {
    this.form.bind('submit', (function(_this) {
      return function(e) {
        var data;
        e.preventDefault();
        data = new FormData(_this.form.get(0));
        _this.disableForm();
        return $.post({
          url: _this.form.attr('action'),
          data: data,
          processData: false,
          contentType: false
        }).done(function(xhr, data) {
          _this.form.find('#success').show();
          _this.form.find('fieldset').hide();
          return _this.resetForm();
        }).fail(function(xhr) {
          _this.markAllFieldsAsSuccess();
          return $.each(xhr.responseJSON, function(k, v) {
            return _this.markFieldAsInvalid(k, v);
          });
        }).always(function(xhr) {
          return _this.enableForm();
        });
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

  MainForm.prototype.resetForm = function() {
    this.form.trigger('reset');
    this.markAllFieldsAsSuccess();
    return this.form.find('input, label, textarea').removeClass('is-valid text-success');
  };

  MainForm.prototype.markAllFieldsAsSuccess = function() {
    this.form.find('input,textarea').removeClass('is-invalid').addClass('is-valid');
    this.form.find('label').removeClass('text-danger').addClass('text-success');
    return this.form.find('small[id$="_error"]').text('');
  };

  MainForm.prototype.markFieldAsInvalid = function(field_id, error) {
    this.form.find("#email_message_" + field_id).removeClass('is-valid').addClass('is-invalid');
    this.form.find("label[for=email_message_" + field_id + "]").removeClass('text-success').addClass('text-danger');
    return this.form.find("#email_message_" + field_id + "_error").text(error);
  };

  MainForm.prototype.enableForm = function() {
    return this.form.find('fieldset').removeAttr('disabled');
  };

  MainForm.prototype.disableForm = function() {
    return this.form.find('fieldset').attr('disabled', '1');
  };

  return MainForm;

})();

$(function() {
  return window.main_form = new MainForm();
});
