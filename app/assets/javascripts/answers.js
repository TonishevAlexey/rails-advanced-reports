$(document).on('turbolinks:load', function () {
    $('.answers').on('click', '.edit-answer-link', function (e) {
        e.preventDefault();
        console.log("plus")
        var answerId = $(this).data('answer-id');
        $('form#edit-answer-' + answerId).removeClass('hidden');
    })
});