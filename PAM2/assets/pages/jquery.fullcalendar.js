/**
* Theme: Minton Admin Template
* Author: Coderthemes
* Component: Full-Calendar
* 
*/

var defaultEvents;


!function($) {
    "use strict";

    var CalendarApp = function() {
        this.$body = $("body")
        this.$modal = $('#event-modal'),
        this.$event = ('#external-events div.external-event'),
        this.$calendar = $('#calendar'),
        this.$saveCategoryBtn = $('.save-category'),
        this.$categoryForm = $('#add-category form'),
        this.$extEvents = $('#external-events'),
        this.$calendarObj = null
    };

    var EventType = "";
    

    /* on drop */
    CalendarApp.prototype.onDrop = function (eventObj, date) {
        var $this = this;
        EventType = eventObj["0"].innerText;
        
        // retrieve the dropped element's stored Event Object
        var originalEventObject = eventObj.data('eventObject');
        var $categoryClass = eventObj.attr('data-class');
        // we need to copy it, so that multiple events don't have a reference to the same object
        var copiedEventObject = $.extend({}, originalEventObject);
        // assign it the date that was reported
        copiedEventObject.start = date;
        if ($categoryClass)
            copiedEventObject['className'] = [$categoryClass];
        // render the event on the calendar
        $this.$calendar.fullCalendar('renderEvent', copiedEventObject, true);
        // is the "remove after drop" checkbox checked?
        if ($('#drop-remove').is(':checked')) {
            // if so, remove the element from the "Draggable Events" list
            eventObj.remove();
        }
    },
    /* on click on event */
    CalendarApp.prototype.onEventClick = function (calEvent, jsEvent, view) {
        var $this = this;
        var startHour=parseInt((calEvent.start / (1000 * 60 * 60)) % 24);
        var startMin = parseInt((calEvent.start / (1000 * 60)) % 60);
        var endHour =parseInt((calEvent.end / (1000 * 60 * 60)) % 24);
        var endMin = parseInt((calEvent.end / (1000 * 60)) % 60);
        if (startMin == 0)
            startMin = "00";
        if (endMin == 0)
            endMin = "00";

        document.getElementById("EventModalTitle").innerText = calEvent.title;
        document.getElementById("EventModalBody").innerText = calEvent.body;
        document.getElementById("EventModalLocation").innerText =calEvent.location;
        document.getElementById("EventModalDateTime").innerText = calEvent.edate + " | " + startHour + ":" + startMin +
            " - " + endHour + ":" + endMin;

        var form = $("<form></form>");
        //form.append("<button>"+txt1+"</button>");
        //form.append("<label>שם האירוע</label>");
        //form.append("<div class='input-group'><input class='form-control' type=text value='" + calEvent.title + "' /><span class='input-group-btn'><button type='submit' class='btn btn-success waves-effect waves-light'><i class='fa fa-check'></i>" + txt2 + "</button></span></div>");

        $this.$modal.modal({
            backdrop: 'static'
        });
        $this.$modal.find('.delete-event').show().end().find('.save-event').hide().end().find('.modal-body').empty().prepend(form).end().find('.delete-event').unbind('click').click(function () {
            $this.$calendarObj.fullCalendar('removeEvents', function (ev) {
                return (ev._id == calEvent._id);
            });
            $this.$modal.modal('hide');
        });
        $this.$modal.find('form').on('submit', function () {
            calEvent.title = form.find("input[type=text]").val();
            $this.$calendarObj.fullCalendar('updateEvent', calEvent);
            $this.$modal.modal('hide');
            return false;
        });
    },
    /* on select */
    CalendarApp.prototype.onSelect = function (start, end, allDay) {
        var $this = this;
        $this.$modal.modal({
            backdrop: 'static'
        });
        var form = $("<form></form>");
        form.append("<div class='row'></div>");
        form.find(".row")
            .append("<div class='col-md-6'><div class='form-group'><label class='control-label'>Event Name</label><input class='form-control' placeholder='Insert Event Name' type='text' name='title'/></div></div>")
            .append("<div class='col-md-6'><div class='form-group'><label class='control-label'>Category</label><select class='form-control' name='category'></select></div></div>")
            .find("select[name='category']")
            .append("<option value='bg-danger'>Danger</option>")
            .append("<option value='bg-success'>Success</option>")
            .append("<option value='bg-purple'>Purple</option>")
            .append("<option value='bg-primary'>Primary</option>")
            .append("<option value='bg-warning'>Warning</option></div></div>");
        $this.$modal.find('.delete-event').hide().end().find('.save-event').show().end().find('.modal-body').empty().prepend(form).end().find('.save-event').unbind('click').click(function () {
            form.submit();
        });
        $this.$modal.find('form').on('submit', function () {
            var title = form.find("input[name='title']").val();
            var beginning = form.find("input[name='beginning']").val();
            var ending = form.find("input[name='ending']").val();
            var categoryClass = form.find("select[name='category'] option:checked").val();
            if (title !== null && title.length != 0) {
                $this.$calendarObj.fullCalendar('renderEvent', {
                    title: title,
                    start: start,
                    end: end,
                    allDay: false,
                    className: categoryClass
                }, true);
                $this.$modal.modal('hide');
            }
            else {
                alert('You have to give a title to your event');
            }
            return false;

        });
        $this.$calendarObj.fullCalendar('unselect');
    },
    CalendarApp.prototype.enableDrag = function () {
        //init events
        $(this.$event).each(function () {
            // create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
            // it doesn't need to have a start or end
            var eventObject = {
                title: $.trim($(this).text()) // use the element's text as the event title
            };
            // store the Event Object in the DOM element so we can get to it later
            $(this).data('eventObject', eventObject);
            // make the event draggable using jQuery UI
            $(this).draggable({
                zIndex: 999,
                revert: true,      // will cause the event to go back to its
                revertDuration: 0  //  original position after the drag
            });
        });
    }

    /* Initializing */
    CalendarApp.prototype.init = function () {
        this.enableDrag();
        /*  Initialize the calendar  */
        var date = new Date();
        var d = date.getDate();
        var m = date.getMonth();
        var y = date.getFullYear();
        var form = '';
        var today = new Date($.now());

        //deside which data to fetch -  Athlete or Coach
        var myEvents;       
        myEvents = JSON.parse(getCoachEvents());
        ////Get the user type according to the user session details
        //var userType = JSON.parse(getUserType());
        ////Get events from db
        //if (userType[0].UserType == 1)
        //    //Athlete
        //    myEvents = JSON.parse(getUserEvents());
        //else if (userType[0].UserType == 2)
        //    //Coach
        //    myEvents = JSON.parse(getCoachEvents());
        //else
        //    //Admin
        //    alert("this is an admin user, and admin dosen't have events");

        //load them into temp var
        var eventList = [];

        //go over each event to exctract date
        for (var i = 0; i < myEvents.length; i++) {

            //take the X event
            event = myEvents[i];

            //Parse the event date into int
            var eventTime = parseInt(event["E_Date"].split("(")[1].split(")")[0]);
            var EventStartDate = new Date(eventTime);
            var strDate = "";
            strDate = EventStartDate.getDay() + "/" + EventStartDate.getMonth() + "/" + EventStartDate.getFullYear();

            //convert to date
            var eventStartDate = new Date(eventTime);
            //Covert the event start time to milliseconds (milliseconds can be converted to the event start hour after.)
            eventStartDate.setMilliseconds(event["StartTime"].TotalMilliseconds);

            //Covert the event start time to milliseconds (milliseconds can be converted to the event start hour after.)
            var eventEndDate = new Date(eventTime);
            eventEndDate.setMilliseconds(event["EndTime"].TotalMilliseconds);

            //Set ClassName in caes of different event types
            //Set default value for the background color
            var cName = "bg-purple";            
            if (event["EventType"] == 2) {                
                cName = "bg-danger";
            }
            else {               
                cName = "bg-primary";
            }

            eventList.push(
                    {
                        title: event["Title"],
                        body:event["E_Body"],                
                        location: event["Location"],
                        note: event["Note"],
                        edate: strDate,
                        start: eventStartDate,
                        end: eventEndDate,
                        className: cName
                    }
                )
        }

        defaultEvents = eventList;
        alert("defaultEvents is set")
        alert(defaultEvents);
        var $this = this;
        $this.$calendarObj = $this.$calendar.fullCalendar({
            slotDuration: '00:15:00', /* If we want to split day time each 15minutes */
            minTime: '08:00:00',
            maxTime: '19:00:00',
            defaultView: 'month',
            handleWindowResize: true,
            height: $(window).height() - 200,
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
            events: defaultEvents,
            editable: true,
            droppable: true, // this allows things to be dropped onto the calendar !!!
            eventLimit: true, // allow "more" link when too many events
            selectable: true,
            drop: function (date) {

                $this.onDrop($(this), date);                
                
                //Send the date to the modal
                $('#EventDate').val(date.format('YYYY-MM-DD'));

                //send the event type to the modal
                $('#EventType').val(EventType);

                //open modal
                $('#createEventModal').modal('show');                 
            },
            select: function (start, end, allDay) { $this.onSelect(start, end, allDay); },
            eventClick: function (calEvent, jsEvent, view) { $this.onEventClick(calEvent, jsEvent, view); },

        });

        //on new event
        this.$saveCategoryBtn.on('click', function () {
            var categoryName = $this.$categoryForm.find("input[name='category-name']").val();
            var categoryColor = $this.$categoryForm.find("select[name='category-color']").val();
            if (categoryName !== null && categoryName.length != 0) {
                $this.$extEvents.append('<div class="external-event bg-' + categoryColor + '" data-class="bg-' + categoryColor + '" style="position: relative;"><i class="fa fa-move"></i>' + categoryName + '</div>')
                $this.enableDrag();
            }

        });
        },

        //init CalendarApp
        $.CalendarApp = new CalendarApp, $.CalendarApp.Constructor = CalendarApp
    }(window.jQuery),

//initializing CalendarApp
function ($) {
    "use strict";
    $.CalendarApp.init()
}(window.jQuery);