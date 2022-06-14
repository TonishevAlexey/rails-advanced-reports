$(document).on('turbolinks:load', function () {
    append_question = function(data) {
        if ($("#question-" + data.question.id)[0] != null) {
            return;
        }
         $('.questions').append( data.question);
    };
    $('.question').on('click', '.create-question-comment', function (e) {
        e.preventDefault();
        var question_id = $('.question')[0].id

        $('div#create-question-comment-' + question_id).removeClass('hidden');
    })
    App.cable.subscriptions.create("QuestionsChannel", {
        connected: function() {
            return this.follow();
        },
        follow: function() {
            return this.perform('follow');
        },
        received: function(data) {

            return append_question(data);
        }
    });
});
