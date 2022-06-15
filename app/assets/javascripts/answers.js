$(document).on('turbolinks:load', function () {

    $('.answers').on('click', '.edit-answer-link', function (e) {
        e.preventDefault();
        var answerId = $(this).data('answer-id');
        $('form#edit-answer-' + answerId).removeClass('hidden');
    })
    $('.answers').on('click', '.create-answer-comment', function (e) {
        e.preventDefault();
        var answerId = $(this).data('answer-id');
        $('div#create-answer-comment-' + answerId).removeClass('hidden');
    })
    append_answer = function(data) {
        if ($("#answer-" + data.answer.id)[0] != null) {
            return;
        }
         $('.answers').append( data.answer);
    };
    App.cable.subscriptions.create("AnswersChannel", {

        connected: function() {
            return this.follow();
        },
        follow: function() {
            var QuestionId = $('.question')[0].id


            return this.perform('follow', {
                question_id: QuestionId
            });
        },
        received: function(data) {

            return append_answer(data);
        }
    });
});
