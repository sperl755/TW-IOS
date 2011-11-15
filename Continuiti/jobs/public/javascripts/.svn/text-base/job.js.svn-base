
jQuery.noConflict();
jQuery('#job_description').keyup(function(evt) {
    str_job_desc = jQuery('#job_description').val();
	//replace(/(^|\r\n|\n)([^*]|$)/g, "$1*$2")
	if(evt.keyCode == 13)
	{
		new_str_job_desc = str_job_desc.replace(/(^|\r\n|\n)([^*]|$)/g, "$1*$2")
		jQuery('#job_description').val(new_str_job_desc);
		return false;
	}
	
});


obj_category = document.getElementById("job_category_id");

/* obj_company = document.getElementById("job_company_id");
obj_industry = document.getElementById("industry");
Event.observe(obj_category,'change',function(){
	industry_display()
	company_display()
});

industry_display()
company_display() */

if($('job_task_location_type_id_1') != null)
{
    select_location('')
}
function select_location(obj){
	if(obj=='')
	{
		if($('job_task_location_type_id_1').checked == true)
			display = "none"
		else
			display = "block"
	}
	else
	{
		if(obj.value==1)
			display = "none"
		else
			display = "block"
	}
	//alert(display)
		$('location').style.display=display
		$('toggle_location').style.display=display
}
/*
function industry_display()
{
	if(obj_category.value == job_category_personal)
		obj_industry.style.display="none"
	else if(obj_category.value == job_category_small_business || obj_category.value == job_category_corporate)
		obj_industry.style.display="block"
}

function company_display()
{
	if(obj_category.value == job_category_personal)
		document.getElementById("company").style.display="none"
	else if(obj_category.value == job_category_small_business || obj_category.value == job_category_corporate)
		document.getElementById("company").style.display="block"
}
*/
function show_private_notes()
{
	document.getElementById("without_private_notes").style.display="none";
	document.getElementById("with_private_notes").style.display="block";
}

function hide_private_notes()
{
	document.getElementById("without_private_notes").style.display="block";
	document.getElementById("with_private_notes").style.display="none";
}
if($("job_title").value=="" || $("job_title").value == job_title_default_text)
{
	$("job_title").className='value-undefined';
	$("job_title").value = job_title_default_text
}

function job_title_focus(){
	if ($("job_title").value == job_title_default_text) {
		$("job_title").className = '';
		$("job_title").value = ""
	}
}

function job_title_blur(){
	if ($("job_title").value == "") {
		$("job_title").className = 'value-undefined';
		$("job_title").value = job_title_default_text
	}
}



if($("job_description").value=="" || $("job_description").value == job_detail_description_default_text)
{
	$("job_description").className='value-undefined';
	$("job_description").value = job_detail_description_default_text
}

function job_detail_description_focus(){
	if ($("job_description").value == job_detail_description_default_text) {
		$("job_description").className = '';
		$("job_description").value = ""
	}
}

function job_detail_description_blur(){
	if ($("job_description").value == "") {
		$("job_description").className = 'value-undefined';
		$("job_description").value = job_detail_description_default_text
	}
}

if($("job_company_description") != null )
{
    if($("job_company_description").value=="" || $("job_company_description").value == company_description_default_text)
    {
        $("job_company_description").className='value-undefined';
        $("job_company_description").value = company_description_default_text
    }

    function company_description_focus(){
        if ($("job_company_description").value == company_description_default_text) {
            $("job_company_description").className = '';
            $("job_company_description").value = ""
        }
    }

    function company_description_blur(){
        if ($("job_company_description").value == "") {
            $("job_company_description").className = 'value-undefined';
            $("job_company_description").value = company_description_default_text
        }
    }
}

if($("job_requirement_list") != null )
{
    if($("job_requirement_list").value=="" || $("job_requirement_list").value == requirement_list_default_text)
    {
        $("job_requirement_list").className='value-undefined';
        $("job_requirement_list").value = requirement_list_default_text
    }

    function requirement_list_focus(){
        if ($("job_requirement_list").value == requirement_list_default_text) {
            $("job_requirement_list").className = '';
            $("job_requirement_list").value = ""
        }
    }

    function requirement_list_blur(){
        if ($("job_requirement_list").value == "") {
            $("job_requirement_list").className = 'value-undefined';
            $("job_requirement_list").value = requirement_list_default_text
        }
    }
}

if($("job_private_description").value=="" || $("job_private_description").value == job_detail_private_default_text)
{
	$("job_private_description").className='value-undefined';
	$("job_private_description").value = job_detail_private_default_text
}

function job_detail_private_focus(){
	if ($("job_private_description").value == job_detail_private_default_text) {
		$("job_private_description").className = '';
		$("job_private_description").value = ""
	}
}

function job_detail_private_blur(){
	if ($("job_private_description").value == "") {
		$("job_private_description").className = 'value-undefined';
		$("job_private_description").value = job_detail_private_default_text
	}
}

if($("job_vehicle").value=="" || $("job_vehicle").value == job_vehicle_default_text)
{
	$("job_vehicle").className='value-undefined';
	$("job_vehicle").value = job_vehicle_default_text
}

function job_vehicle_focus(){
	if ($("job_vehicle").value == job_vehicle_default_text) {
		$("job_vehicle").className = '';
		$("job_vehicle").value = ""
	}
}

function job_vehicle_blur(){
	if ($("job_vehicle").value == "") {
		$("job_vehicle").className = 'value-undefined';
		$("job_vehicle").value = job_vehicle_default_text
	}
}


function calculate_expected_cost(){
	if ($('job_time_unit_id') != null && $('job_time_unit_id').value != "") {
        extected_time = $('job_average_expected_time').value
        cost_per_time_unit = $('job_cost_per_time_unit').value
        expense_required = $('job_expense_required').value

		extected_time = parseInt(extected_time)
		cost_per_time_unit = parseInt(cost_per_time_unit)
		expense_required = parseInt(expense_required)

        if(isNaN(extected_time))
            extected_time = 0
        if(isNaN(cost_per_time_unit))
                    cost_per_time_unit = 0
        if(isNaN(expense_required))
                    expense_required = 0
		
		$('job_average_expected_cost').value = (extected_time * cost_per_time_unit) + expense_required
	}
    else if($('job_time_unit_id') == null)
    {
        job_fixed_cost_amount = $('job_fixed_cost_amount').value
        job_expense_required = $('job_expense_required').value
        job_fixed_cost_amount = parseInt(job_fixed_cost_amount)
        job_expense_required = parseInt(job_expense_required)

        if(isNaN(job_fixed_cost_amount))
            job_fixed_cost_amount = 0
        if(isNaN(job_expense_required))
            job_expense_required = 0
        
        $('job_average_expected_cost').value = job_fixed_cost_amount + job_expense_required
    }
}