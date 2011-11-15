// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function trim(str)
{
  if(!str || typeof str != 'string')
    return null;

  return str.replace(/^[\s]+/,'').replace(/[\s]+$/,'').replace(/[\s]{2,}/,' ');
}

function dateToPresent(elementValue, currentIndexForm)  {
  if(elementValue == true) {
    $("until-date-form-"+currentIndexForm).hide();
    $("present-date-"+currentIndexForm).show();
  }
  else  {
    $("until-date-form-"+currentIndexForm).show();
    $("present-date-"+currentIndexForm).hide();
  }
}

function toggleDatePresent(elementValue, currentIndexForm)  {
  if(elementValue == true) {
    $("to_"+currentIndexForm).hide();
    $("to_current_"+currentIndexForm).show();
  }
  else  {
    $("to_"+currentIndexForm).show();
    $("to_current_"+currentIndexForm).hide();
  }
}


function validateFieldCantBeBlank(elementId, messageErrorElementId) {
  if(trim($(elementId).value) == "" || trim($(elementId).value) == null)
    $(messageErrorElementId).show();
  else
    $(messageErrorElementId).hide();
}

function validateDateAttended(kind, currentFormIndex) {
  if($("education_"+currentFormIndex+"_from_year") != null && $("education_"+currentFormIndex+"_end_year") != null) {
    var startYear = $("education_"+currentFormIndex+"_from_year").value;
    var endYear = $("education_"+currentFormIndex+"_end_year").value;
    var convertedStartYear;
    var convertedEndYear;
  
    if(kind == "start year")  {
      convertedStartYear = parseInt(startYear);
      if((trim(startYear) == "" || trim(startYear) == null)
        || ((isNaN(convertedStartYear) || convertedStartYear <= 1900) && trim(startYear) != "" && trim(startYear) != null)) {
        $("education_year_must_enter_after_1900_"+currentFormIndex).show();
        $("education_end_year_must_greater_than_start_year_"+currentFormIndex).hide();
        $("education_end_year_must_enter_after_1900_"+currentFormIndex).hide();
      }
      else if(trim(startYear) != "" && trim(startYear) != null) {
        convertedEndYear = parseInt(endYear);
        if(!isNaN(convertedEndYear))  {
          if(convertedStartYear > convertedEndYear && convertedEndYear > 1900) {
            $("education_end_year_must_greater_than_start_year_"+currentFormIndex).show();
            $("education_end_year_must_enter_after_1900_"+currentFormIndex).hide();
            $("education_year_must_enter_after_1900_"+currentFormIndex).hide();
          }
          else if(convertedStartYear > convertedEndYear) {
            $("education_end_year_must_greater_than_start_year_"+currentFormIndex).show();
            $("education_end_year_must_enter_after_1900_"+currentFormIndex).show();
            $("education_year_must_enter_after_1900_"+currentFormIndex).hide();
          }
          else {
            $("education_end_year_must_greater_than_start_year_"+currentFormIndex).hide();
            $("education_end_year_must_enter_after_1900_"+currentFormIndex).hide();
            $("education_year_must_enter_after_1900_"+currentFormIndex).hide();
          }
        }
        else if(isNaN(convertedEndYear) && trim(endYear) != "" && trim(endYear) != null)  {
          $("education_end_year_must_greater_than_start_year_"+currentFormIndex).hide();
          $("education_end_year_must_enter_after_1900_"+currentFormIndex).show();
          $("education_year_must_enter_after_1900_"+currentFormIndex).hide();
        }
        else  {
          $("education_end_year_must_greater_than_start_year_"+currentFormIndex).hide();
          $("education_end_year_must_enter_after_1900_"+currentFormIndex).hide();
          $("education_year_must_enter_after_1900_"+currentFormIndex).hide();
        }
      }
    }
    else if(kind == "end year")  {
      convertedEndYear = parseInt(endYear);
      if((trim(endYear) == "" || trim(endYear) == null)
        || ((isNaN(convertedEndYear) || convertedEndYear <= 1900) && trim(endYear) != "" && trim(endYear) != null)) {
        $("education_end_year_must_greater_than_start_year_"+currentFormIndex).hide();
        $("education_end_year_must_enter_after_1900_"+currentFormIndex).show();
        $("education_year_must_enter_after_1900_"+currentFormIndex).hide();
      }
      else if(trim(endYear) != "" && trim(endYear) != null) {
        convertedStartYear = parseInt(startYear);
        if(!isNaN(convertedStartYear))  {
          if(convertedStartYear > convertedEndYear && convertedStartYear > 1900) {
            $("education_end_year_must_greater_than_start_year_"+currentFormIndex).show();
            $("education_end_year_must_enter_after_1900_"+currentFormIndex).hide();
            $("education_year_must_enter_after_1900_"+currentFormIndex).hide();
          }
          else if(convertedStartYear > convertedEndYear) {
            $("education_end_year_must_greater_than_start_year_"+currentFormIndex).show();
            $("education_end_year_must_enter_after_1900_"+currentFormIndex).show();
            $("education_year_must_enter_after_1900_"+currentFormIndex).hide();
          }
          else {
            $("education_end_year_must_greater_than_start_year_"+currentFormIndex).hide();
            $("education_end_year_must_enter_after_1900_"+currentFormIndex).hide();
            $("education_year_must_enter_after_1900_"+currentFormIndex).hide();
          }
        }
        else if(isNaN(convertedStartYear) && trim(startYear) != "" && trim(startYear) != null)  {
          $("education_end_year_must_greater_than_start_year_"+currentFormIndex).hide();
          $("education_end_year_must_enter_after_1900_"+currentFormIndex).hide();
          $("education_year_must_enter_after_1900_"+currentFormIndex).show();
        }
        else  {
          $("education_end_year_must_greater_than_start_year_"+currentFormIndex).hide();
          $("education_end_year_must_enter_after_1900_"+currentFormIndex).hide();
          $("education_year_must_enter_after_1900_"+currentFormIndex).hide();
        }
      }
    }
    else if(kind == "after button click")  {
      convertedStartYear = parseInt(startYear);
      convertedEndYear = parseInt(endYear);
      if((isNaN(convertedStartYear) && trim(startYear) != "" && trim(startYear) != null) ||
        (isNaN(convertedEndYear) && trim(endYear) != "" && trim(endYear) != null)) {
        $("education_end_year_must_greater_than_start_year_"+currentFormIndex).hide();
        if(isNaN(convertedEndYear))
          $("education_end_year_must_enter_after_1900_"+currentFormIndex).show();
        if(isNaN(convertedStartYear))
          $("education_year_must_enter_after_1900_"+currentFormIndex).show();
        return false;
      }
      else if(trim(startYear) != "" && trim(startYear) != null && trim(endYear) != "" && trim(endYear) != null) {
        if(convertedStartYear <= 1900 || convertedEndYear <= 1900) {
          $("education_end_year_must_greater_than_start_year_"+currentFormIndex).hide();
          if(convertedEndYear <= 1900)
            $("education_end_year_must_enter_after_1900_"+currentFormIndex).show();
          if(convertedStartYear <= 1900)
            $("education_year_must_enter_after_1900_"+currentFormIndex).show();
          return false;
        }
        else if(convertedStartYear > convertedEndYear) {
          $("education_end_year_must_greater_than_start_year_"+currentFormIndex).show();
          $("education_end_year_must_enter_after_1900_"+currentFormIndex).hide();
          $("education_year_must_enter_after_1900_"+currentFormIndex).hide();
          return false;
        }
        else  {
          $("education_end_year_must_greater_than_start_year_"+currentFormIndex).hide();
          $("education_end_year_must_enter_after_1900_"+currentFormIndex).hide();
          $("education_year_must_enter_after_1900_"+currentFormIndex).hide();
          return true;
        }
      }
      else if(trim(startYear) == "" || trim(startYear) == null || trim(endYear) == "" || trim(endYear) == null)  {
        $("education_end_year_must_greater_than_start_year_"+currentFormIndex).hide();
        if(trim(endYear) == "" || trim(endYear) == null)
          $("education_end_year_must_enter_after_1900_"+currentFormIndex).show();
        if(trim(startYear) == "" || trim(startYear) == null)
          $("education_year_must_enter_after_1900_"+currentFormIndex).show();
        return false;
      }
    }
  }
}

function validateBetweenFromAndEndYear(startYearElementId, endYearElementId, toPresent, kind,
firstMessageErrorElementId, messageErrorEndMustGreaterThanStartElementId,
messageErrorEndYearMustGreaterThan1900ElementId, startMonthCantBlank, endMonthCantBlank, fromMonthId,
endMonthId) {
  var startYear = $(startYearElementId).value;
  var endYear = $(endYearElementId).value;
  var convertedStartYear;
  var convertedEndYear;
  if(!toPresent)  {
    if(kind == "start year")  {
      convertedStartYear = parseInt(startYear);
      if((isNaN(convertedStartYear) && trim(startYear) != "" && trim(startYear) != null)
        || (trim(startYear) == "" || trim(startYear) == null)
        || (!isNaN(convertedStartYear) && trim(startYear) != "" && trim(startYear) != null && convertedStartYear <= 1900)) {
        $(firstMessageErrorElementId).show();
        $(messageErrorEndMustGreaterThanStartElementId).hide();
        $(messageErrorEndYearMustGreaterThan1900ElementId).hide();
      }
      else if(convertedStartYear > 1900)
        if(trim(endYear) == "" || trim(endYear) == null)  {
          $(firstMessageErrorElementId).hide();
          $(messageErrorEndMustGreaterThanStartElementId).hide();
          $(messageErrorEndYearMustGreaterThan1900ElementId).hide();
        }
      else  {
        convertedEndYear = parseInt(endYear);
        if(!isNaN(convertedEndYear))  {
          if(convertedStartYear > convertedEndYear && convertedEndYear > 1900) {
            $(firstMessageErrorElementId).hide();
            $(messageErrorEndMustGreaterThanStartElementId).show();
            $(messageErrorEndYearMustGreaterThan1900ElementId).hide();
          }
          else if(convertedStartYear > convertedEndYear) {
            $(firstMessageErrorElementId).hide();
            $(messageErrorEndMustGreaterThanStartElementId).show();
            $(messageErrorEndYearMustGreaterThan1900ElementId).show();
          }
          else  {
            $(firstMessageErrorElementId).hide();
            $(messageErrorEndMustGreaterThanStartElementId).hide();
            $(messageErrorEndYearMustGreaterThan1900ElementId).hide();
          }
        }
        else  {
          $(firstMessageErrorElementId).hide();
          $(messageErrorEndMustGreaterThanStartElementId).hide();
          $(messageErrorEndYearMustGreaterThan1900ElementId).show();
        }
      }
    }
    else if(kind == "end year")  {
      convertedEndYear = parseInt(endYear);
      if((isNaN(convertedEndYear) && trim(endYear) != "" && trim(endYear) != null)
        || (trim(endYear) == "" || trim(endYear) == null)
        || (!isNaN(convertedEndYear) && trim(endYear) != "" && trim(endYear) != null && convertedEndYear <= 1900)) {
        $(firstMessageErrorElementId).hide();
        $(messageErrorEndMustGreaterThanStartElementId).hide();
        $(messageErrorEndYearMustGreaterThan1900ElementId).show();
      }
      else if(convertedEndYear > 1900)
        if(trim(startYear) == "" || trim(startYear) == null)  {
          $(firstMessageErrorElementId).hide();
          $(messageErrorEndMustGreaterThanStartElementId).hide();
          $(messageErrorEndYearMustGreaterThan1900ElementId).hide();
        }
      else  {
        convertedStartYear = parseInt(startYear);
        if(!isNaN(convertedStartYear))  {
          if(convertedStartYear > convertedEndYear && convertedStartYear > 1900) {
            $(firstMessageErrorElementId).hide();
            $(messageErrorEndMustGreaterThanStartElementId).show();
            $(messageErrorEndYearMustGreaterThan1900ElementId).hide();
          }
          else if(convertedStartYear > convertedEndYear) {
            $(firstMessageErrorElementId).show();
            $(messageErrorEndMustGreaterThanStartElementId).show();
            $(messageErrorEndYearMustGreaterThan1900ElementId).hide();
          }
          else  {
            $(firstMessageErrorElementId).hide();
            $(messageErrorEndMustGreaterThanStartElementId).hide();
            $(messageErrorEndYearMustGreaterThan1900ElementId).hide();
          }
        }
        else  {
          $(firstMessageErrorElementId).show();
          $(messageErrorEndMustGreaterThanStartElementId).hide();
          $(messageErrorEndYearMustGreaterThan1900ElementId).hide();
        }
      }
    }
    else if(kind == "after button click")  {
      convertedStartYear = parseInt(startYear);
      convertedEndYear = parseInt(endYear);
      if((trim(startYear) == "" || trim(startYear) == null || trim(endYear) == "" || trim(endYear) == null)
        || (isNaN(convertedStartYear) && trim(startYear) != "" && trim(startYear) != null) ||
        (isNaN(convertedEndYear) && trim(endYear) != "" && trim(endYear) != null)) {
        $(firstMessageErrorElementId).show();
        $(messageErrorEndMustGreaterThanStartElementId).hide();
        $(messageErrorEndYearMustGreaterThan1900ElementId).hide();
        $(startMonthCantBlank).hide();
        $(endMonthCantBlank).hide();
        return false;
      }
      else if(trim(startYear) != "" && trim(startYear) != null && trim(endYear) != "" && trim(endYear) != null) {
        if(convertedStartYear <= 1900 || convertedEndYear <= 1900) {
          if(convertedStartYear <= 1900)
            $(firstMessageErrorElementId).show();
          $(messageErrorEndMustGreaterThanStartElementId).hide();
          if(convertedEndYear <= 1900)
            $(messageErrorEndYearMustGreaterThan1900ElementId).show();
          $(startMonthCantBlank).hide();
          $(endMonthCantBlank).hide();
          return false;
        }
        else if(convertedStartYear > convertedEndYear) {
          $(messageErrorEndYearMustGreaterThan1900ElementId).hide();
          $(messageErrorEndMustGreaterThanStartElementId).show();
          $(firstMessageErrorElementId).hide();
          $(startMonthCantBlank).hide();
          $(endMonthCantBlank).hide();
          return false;
        }
        else  {
          $(messageErrorEndYearMustGreaterThan1900ElementId).hide();
          $(messageErrorEndMustGreaterThanStartElementId).hide();
          $(firstMessageErrorElementId).hide();
          $(startMonthCantBlank).hide();
          $(endMonthCantBlank).hide();
          if(trim($(fromMonthId).value) == null || trim($(fromMonthId).value) == ""
            || trim($(endMonthId).value) == null || trim($(endMonthId).value) == "")  {
            $(messageErrorEndYearMustGreaterThan1900ElementId).hide();
            $(messageErrorEndMustGreaterThanStartElementId).hide();
            $(firstMessageErrorElementId).hide();
            if(trim($(fromMonthId).value) == null || trim($(fromMonthId).value) == "")
              $(startMonthCantBlank).show();
            if(trim($(endMonthId).value) == null || trim($(endMonthId).value) == "")
              $(endMonthCantBlank).show();
            return false;
          }
          else  {
            var startDateToTime = (new Date(startYear, String((parseInt(trim($(fromMonthId).value)) - 1)), "1")).getTime();
            var endDateToTime = (new Date(endYear, String((parseInt(trim($(endMonthId).value)) - 1)), "1")).getTime();
            if(endDateToTime < startDateToTime) {
              $(messageErrorEndYearMustGreaterThan1900ElementId).hide();
              $(messageErrorEndMustGreaterThanStartElementId).show();
              $(firstMessageErrorElementId).hide();
              $(startMonthCantBlank).hide();
              $(endMonthCantBlank).hide();
              return false;
            }
          }
          return true;
        }
      }
    }
  }
  else
    if(kind == "start year")  {
      convertedStartYear = parseInt(startYear);
      if((isNaN(convertedStartYear) && trim(startYear) != "" && trim(startYear) != null)
        || (trim(startYear) == "" || trim(startYear) == null)
        || (!isNaN(convertedStartYear) && trim(startYear) != "" && trim(startYear) != null && convertedStartYear <= 1900)) {
        $(firstMessageErrorElementId).show();
        $(messageErrorEndMustGreaterThanStartElementId).hide();
        $(messageErrorEndYearMustGreaterThan1900ElementId).hide();
      }
    else if(convertedStartYear > 1900)  {
      $(firstMessageErrorElementId).hide();
      $(messageErrorEndMustGreaterThanStartElementId).hide();
      $(messageErrorEndYearMustGreaterThan1900ElementId).hide();
    }
  }
  else if(kind == "after button click")  {
    convertedStartYear = parseInt(startYear);
    if((trim(startYear) == "" || trim(startYear) == null)
      || (isNaN(convertedStartYear) && trim(startYear) != "" && trim(startYear) != null)) {
      $(firstMessageErrorElementId).show();
      $(messageErrorEndMustGreaterThanStartElementId).hide();
      $(messageErrorEndYearMustGreaterThan1900ElementId).hide();
      $(startMonthCantBlank).hide();
      $(endMonthCantBlank).hide();
      return false;
    }
    else if(trim(startYear) != "" && trim(startYear) != null) {
      if(convertedStartYear <= 1900) {
        $(firstMessageErrorElementId).show();
        $(messageErrorEndMustGreaterThanStartElementId).hide();
        $(messageErrorEndYearMustGreaterThan1900ElementId).hide();
        $(startMonthCantBlank).hide();
        $(endMonthCantBlank).hide();
        return false;
      }
      else  {
        $(messageErrorEndYearMustGreaterThan1900ElementId).hide();
        $(messageErrorEndMustGreaterThanStartElementId).hide();
        $(firstMessageErrorElementId).hide();
        $(startMonthCantBlank).hide();
        $(endMonthCantBlank).hide();
        if(trim($(fromMonthId).value) == null || trim($(fromMonthId).value) == "")  {
          $(messageErrorEndYearMustGreaterThan1900ElementId).hide();
          $(messageErrorEndMustGreaterThanStartElementId).hide();
          $(firstMessageErrorElementId).hide();
          $(startMonthCantBlank).show();
          $(endMonthCantBlank).hide();
          return false;
        }
        return true;
      }
    }
  }
}

function validateTwoIntegerValue(firstValue, secondValue, messageError) {
  var bothValueValid = true;
  if(isNaN(parseInt(firstValue)) || (trim(secondValue) != "" && trim(secondValue) != null && isNaN(parseInt(secondValue))))  {
    bothValueValid = false;
  }
  else
    if(parseInt(firstValue) < 0 || (trim(secondValue) != "" && trim(secondValue) != null && parseInt(secondValue) < 0))  {
      bothValueValid = false;
    }

  if(bothValueValid == false)  {
    alert(messageError);
    return false;
  }
  else
    return true;
}

function validateYear(value) {
  var yearLength = value.length;
  var convertedYear;
  var yearValid = true;
  if(yearLength == 0)
    yearValid = false;
  else if(isNaN(parseInt(value)))
    yearValid = false;
  else  {
    convertedYear = String(parseInt(value));
    if(convertedYear.length < 4)
      yearValid = false;
    else
      if(parseInt(value) < 0)
        yearValid = false;
  }

  if(yearValid == false)  {
    alert("Year award is not valid!");
    return false;
  }
  else
    return true;
}

function validateAllEducationFields() {
  var totalOpenedForm = window.formIndex + 1;
  var valid = true;
  for(var i = 1; i <= totalOpenedForm; i++) {
    if($("education_"+(i - 1)+"_organization") != null && (trim($("education_"+(i - 1)+"_organization").value) == "" || trim($("education_"+(i - 1)+"_organization").value) == null))  {
      $("education_university_cant_be_blank_"+(i - 1)).show();
      valid = false;
    }

    if($("education_"+(i - 1)+"_major") != null && (trim($("education_"+(i - 1)+"_major").value) == "" || trim($("education_"+(i - 1)+"_major").value) == null))  {
      $("education_major_cant_be_blank_"+(i - 1)).show();
      valid = false;
    }

    if($("education_"+(i - 1)+"_degree") != null && (trim($("education_"+(i - 1)+"_degree").value) == "" || trim($("education_"+(i - 1)+"_degree").value) == null))  {
      $("education_degree_cant_be_blank_"+(i - 1)).show();
      valid = false;
    }

    if($("education_"+(i - 1)+"_degree") != null && !validateDateAttended('after button click', (i-1)))
      valid = false;

    if($('education_'+(i - 1)+'_url') != null && !validateURLAddress('education_'+(i - 1)+'_url', 'education_university_url_not_valid_'+(i - 1)))
      valid = false;

    if(i == totalOpenedForm && !valid)
      return false;
    else if(i == totalOpenedForm && valid)
      return true;
    else if(i == totalOpenedForm)
      return false;
  }
}

function validateAllExperienceFields(kind) {
  var totalOpenedForm = window.experienceFormIndex + 1;
  var valid = true;
  for(var i = 1; i <= totalOpenedForm; i++) {
    if($("experience_"+(i - 1)+"_company_name") != null && (trim($("experience_"+(i - 1)+"_company_name").value) == "" || trim($("experience_"+(i - 1)+"_company_name").value) == null))  {
      $("experience_company_name_cant_be_blank_"+(i - 1)).show();
      valid = false;
    }

    if($("experience_"+(i - 1)+"_title") != null && (trim($("experience_"+(i - 1)+"_title").value) == "" || trim($("experience_"+(i - 1)+"_title").value)) == null)  {
      $("experience_title_cant_be_blank_"+(i - 1)).show();
      valid = false;
    }

    if($("experience_"+(i - 1)+"_title") != null && !validateBetweenFromAndEndYear('experience_'+(i - 1)+'_from_year', "experience_"+(i - 1)+"_end_year", $('experience_'+(i - 1)+'_current').checked, kind, 'experience_year_must_enter_after_1900_'+(i - 1), 'experience_end_year_must_greater_than_start_year_'+(i - 1), 'experience_end_year_must_enter_after_1900_'+(i - 1), 'experience_start_month_cant_be_blank_'+(i - 1), 'experience_end_month_cant_be_blank_'+(i - 1), 'experience_'+(i - 1)+'_from_month', 'experience_'+(i - 1)+'_end_month'))
      valid = false;

    if($("experience_"+(i - 1)+"_company_url") && !validateURLAddress('experience_'+(i - 1)+'_company_url', 'experience_company_url_not_valid_'+(i - 1)))
      valid = false;

    if(i == totalOpenedForm && !valid)
      return false;
    else if(i == totalOpenedForm && valid)
      return true;
    else if(i == totalOpenedForm)
      return false;
  }
}

function valueMustInteger(elementId, errorMessageMustInteger, errorMessageMustGreaterThanZero) {
  if(trim($(elementId).value) != "" && trim($(elementId).value) != null)  {
    var value = parseInt($(elementId).value);
    if(isNaN(value))  {
      $(errorMessageMustInteger).show();
      $(errorMessageMustGreaterThanZero).hide();
      return false;
    }
    else if(value < 1)  {
      $(errorMessageMustInteger).hide();
      $(errorMessageMustGreaterThanZero).show();
      return false;
    }
    else  {
      $(errorMessageMustInteger).hide();
      $(errorMessageMustGreaterThanZero).hide();
      return true;
    }
  }
  else  {
    $(errorMessageMustInteger).hide();
    $(errorMessageMustGreaterThanZero).hide();
    return true;
  }
}

function validateAllSkillFields() {
  var totalOpenedForm = window.userSkillFormIndex + 1;
  var valid = true;
  for(var i = 1; i <= totalOpenedForm; i++) {
    if($("user_skill_"+(i - 1)+"_title") != null && (trim($("user_skill_"+(i - 1)+"_title").value) == "" || trim($("user_skill_"+(i - 1)+"_title").value) == null))  {
      $("user_skill_title_cant_be_blank_"+(i - 1)).show();
      valid = false;
    }

    if($("user_skill_"+(i - 1)+"_description") != null && (trim($("user_skill_"+(i - 1)+"_description").value) == "" || trim($("user_skill_"+(i - 1)+"_description").value) == null))  {
      $("user_skill_description_cant_be_blank_"+(i - 1)).show();
      valid = false;
    }

    if(($("user_skill_"+(i - 1)+"_year_period") && (trim($("user_skill_"+(i - 1)+"_year_period").value) == "" || trim($("user_skill_"+(i - 1)+"_year_period").value) == null)) ||
      ($("user_skill_"+(i - 1)+"_month_period") != null && (trim($("user_skill_"+(i - 1)+"_month_period").value) == "" || trim($("user_skill_"+(i - 1)+"_month_period").value) == null))) {
      $("user_skill_year_or_month_cant_be_blank_"+(i - 1)).show();
      valid = false;
    }

    if($('user_skill_'+(i - 1)+'_year_period') != null && !valueMustInteger('user_skill_'+(i - 1)+'_year_period', 'user_skill_year_must_integer_'+(i - 1), 'user_skill_year_must_greater_than_zero_'+(i - 1)))
      valid = false;

    if($('user_skill_'+(i - 1)+'_month_period') != null && !valueMustInteger('user_skill_'+(i - 1)+'_month_period', 'user_skill_month_must_integer_'+(i - 1), 'user_skill_month_must_greater_than_zero_'+(i - 1)))
      valid = false;

    if(!valid && i == totalOpenedForm)
      return false;
    else if(i == totalOpenedForm)
      return true;
  }
}

function validateSingleYear(elementId, errorMessageElementId, monthCantBlank, kind) {
  var singleYear = $(elementId).value;
  var convertedSingleYear;

  if(kind == "after filled field")  {
    convertedSingleYear = parseInt(singleYear);
    if(isNaN(convertedSingleYear) && trim(singleYear) != "" && trim(singleYear) != null) {
      $(errorMessageElementId).show();
      $(monthCantBlank).hide();
      return false;
    }
    else if(trim(singleYear) != "" && trim(singleYear) != null) {
      if(convertedSingleYear <= 1900) {
        $(errorMessageElementId).show();
        $(monthCantBlank).hide();
        return false;
      }
      else  {
        $(errorMessageElementId).hide();
        $(monthCantBlank).hide();
        return false;
      }
    }
    else  {
      $(errorMessageElementId).show();
      $(monthCantBlank).hide();
      return false;
    }
  }
  else if(kind == "after button click")  {
    convertedSingleYear = parseInt(singleYear);
    if((isNaN(convertedSingleYear) && trim(singleYear) != "" && trim(singleYear) != null)
      || trim(singleYear) == "" || trim(singleYear) == null) {
      $(errorMessageElementId).show();
      return false;
    }
    else if(trim(singleYear) != "" && trim(singleYear) != null) {
      if(convertedSingleYear <= 1900) {
        $(errorMessageElementId).show();
        return false;
      }
      else  {
        $(errorMessageElementId).hide();
        return true;
      }
    }
  }
}

function validateAllCertificationFields() {
  var totalOpenedForm = window.certificationFormIndex + 1;
  var valid = true;
  for(var i = 1; i <= totalOpenedForm; i++) {
    if($("certification_"+(i - 1)+"_title") != null && (trim($("certification_"+(i - 1)+"_title").value) == "" || trim($("certification_"+(i - 1)+"_title").value) == null))  {
      $("certification_title_cant_be_blank_"+(i - 1)).show();
      valid = false;
    }

    if($("certification_"+(i - 1)+"_award_date_2i") != null && (trim($("certification_"+(i - 1)+"_award_date_2i").value) == "" || trim($("certification_"+(i - 1)+"_award_date_2i").value) == null))  {
      $("certification_month_cant_be_blank_"+(i - 1)).show();
      valid = false;
    }

    if($('certification_'+(i - 1)+'_award_year') != null && (!validateSingleYear('certification_'+(i - 1)+'_award_year', 'certification_year_must_enter_after_1900_'+(i - 1)+'', 'certification_month_cant_be_blank_'+(i - 1)+'', 'after button click') || !valid))
      valid = false;

    if(!valid && i == totalOpenedForm)
      return false;
    else if(i == totalOpenedForm)
      return true;

  }
}

function validateAllInterestFields()  {
  var totalOpenedForm = window.interestFormIndex + 1;
  var valid = true;
  for(var i = 1; i <= totalOpenedForm; i++) {
    if($("interest_"+(i - 1)+"_name") != null && (trim($("interest_"+(i - 1)+"_name").value) == "" || trim($("interest_"+(i - 1)+"_name").value) == null))  {
      $("interest_name_cant_be_blank_"+(i - 1)).show();
      valid = false;
    }
  }
  return valid;
}

function validateAllMembershipFields() {
  var totalOpenedForm = window.membershipFormIndex + 1;
  var valid = true;
  for(var i = 1; i <= totalOpenedForm; i++) {
    if($("membership_"+(i - 1)+"_name") != null && (trim($("membership_"+(i - 1)+"_name").value) == "" || trim($("membership_"+(i - 1)+"_name").value) == null))  {
      $("membership_name_cant_be_blank_"+(i - 1)).show();
      valid = false;
    }

    if($('membership_'+(i - 1)+'_from_year') != null && !validateBetweenFromAndEndYear('membership_'+(i - 1)+'_from_year', 'membership_'+(i - 1)+'_until_year', $('membership_'+(i - 1)+'_to_present').checked, 'after button click', 'membership_year_must_enter_after_1900_'+(i - 1), 'membership_end_year_must_greater_than_start_year_'+(i - 1), 'membership_end_year_must_enter_after_1900_'+(i - 1), 'membership_start_month_cant_be_blank_'+(i - 1), 'membership_end_month_cant_be_blank_'+(i - 1), 'membership_'+(i - 1)+'_from_date_2i', 'membership_'+(i - 1)+'_until_date_2i'))
      valid = false;

    if(!valid && i == totalOpenedForm)
      return false;
    else if(i == totalOpenedForm)
      return true;
  }
}

function validateAllUserDescriptionFields() {
  if(trim($("user_description_description").value) == "" || trim($("user_description_description").value) == null)  {
    $("user_description_description_cant_be_blank").show();
    return false;
  }
  else
    return true;
}

function addNewEducationMultipleForm()  {
  window.formIndex = window.formIndex + 1;
  Element.insert("education_fields", {
    bottom: "<div class=\"education_field\">\n\
                <p>\n\
                  <div style=\"float:left;width:150px;\">\n\
                    <b><label for=\"user_new_education_attributes__organization\">School/University</label>:</b>\n\
                  </div>\n\
                  <span id=\"education_university_cant_be_blank_"+window.formIndex+"\" style=\"display: none\">\n\
                    <div style=\"float: right; width:350px; color: red\">School/University can't blank</div>\n\
                  </span>\n\
                  <div style=\"float: right; width:350px;\">\n\
                    <input id=\"education_"+window.formIndex+"_organization\" name=\"education["+window.formIndex+"][organization]\" onchange=\"validateFieldCantBeBlank('education_"+window.formIndex+"_organization', 'education_university_cant_be_blank_"+window.formIndex+"')\" size=\"30\" type=\"text\" />\n\
                  </div>\n\
                  <div style=\"clear:both;\"></div>\n\
                </p>\n\
                <p>\n\
                  <div style=\"float:left;width:150px;\">\n\
                    <b><label for=\"user_new_education_attributes__url\">School/University URL</label>:</b>\n\
                    </div>\n\
                    <span id=\"education_university_url_not_valid_"+window.formIndex+"\" style=\"display: none\">\n\
                      <div style=\"float: right; width:350px; color: red\">School/University URL is not valid</div>\n\
                    </span>\n\
                      <div style=\"float: right; width:350px;\">\n\
                        <input id=\"education_"+window.formIndex+"_url\" name=\"education["+window.formIndex+"][url]\" size=\"30\" type=\"text\" onchange=\"validateURLAddress('education_"+window.formIndex+"_url', 'education_university_url_not_valid_"+window.formIndex+"')\" />\n\
                      </div>\n\
                      <div style=\"clear:both;\"></div>\n\
                </p>\n\
                <p>\n\
                  <div style=\"float:left;width:160px;\">\n\
                    <b><label for=\"user_new_education_attributes__degree\">Degree</label>:</b>\n\
                  </div>\n\
                  <span id=\"education_degree_cant_be_blank_"+window.formIndex+"\" style=\"display: none\">\n\
                    <div style=\"float: right; width:350px; color: red\">Degree can't blank</div>\n\
                  </span>\n\
                  <div style=\"float: right; width:350px;\">\n\
                    <input id=\"education_"+window.formIndex+"_degree\" name=\"education["+window.formIndex+"][degree]\" onchange=\"validateFieldCantBeBlank('education_"+window.formIndex+"_degree', 'education_degree_cant_be_blank_"+window.formIndex+"')\" size=\"4\" type=\"text\" />\n\
                  </div>\n\
                  <div style=\"clear:both;\"></div>\n\
                </p>\n\
                <p>\n\
                  <div style=\"float:left;width:150px;\"><b>Field(s) of study:</b></div>\n\
                  <span id=\"education_major_cant_be_blank_"+window.formIndex+"\" style=\"display: none\">\n\
                    <div style=\"float: right; width:350px; color: red\">Field(s) of study can't blank</div>\n\
                  </span>\n\
                  <div style=\"float: right; width:350px;\">\n\
                    <input id=\"education_"+window.formIndex+"_major\" name=\"education["+window.formIndex+"][major]\" onchange=\"validateFieldCantBeBlank('education_"+window.formIndex+"_major', 'education_major_cant_be_blank_"+window.formIndex+"')\" size=\"30\" type=\"text\" />\n\
                  </div>\n\
                  <div style=\"clear:both;\"></div>\n\
                </p>\n\
                <p>\n\
                  <div style=\"float:left;width:150px;display:inline;\"><b>Dates Attended:</b></div>\n\
                  <span id=\"education_year_must_enter_after_1900_"+window.formIndex+"\" style=\"display: none\">\n\
                    <div style=\"float:right;width:350px;color: red\">Please enter a year after 1900.</div>\n\
                  </span>\n\
                  <span id=\"education_end_year_must_enter_after_1900_"+window.formIndex+"\" style=\"display: none\">\n\
                    <div style=\"float:right;width:350px;color: red\">Please enter an end year after 1900.</div>\n\
                  </span>\n\
                  <span id=\"education_end_year_must_greater_than_start_year_"+window.formIndex+"\" style=\"display: none\">\n\
                    <div style=\"float:right;width:350px;color: red\">End year must equal or greater than start year.</div>\n\
                  </span>\n\
                  <div style=\"float:right;width:350px;\">\n\
                    <input id=\"education_"+window.formIndex+"_from_year\" maxlength=\"4\" name=\"education["+window.formIndex+"][from_year]\" onchange=\"validateDateAttended('start year', "+window.formIndex+")\" size=\"4\" type=\"text\" />\n\
                      to\n\
                    <input id=\"education_"+window.formIndex+"_end_year\" maxlength=\"4\" name=\"education["+window.formIndex+"][end_year]\" onchange=\"validateDateAttended('end year', "+window.formIndex+")\" size=\"4\" type=\"text\" />\n\
                  </div>\n\
                  <div style=\"clear:both;\"></div>\n\
                </p>\n\
                <p>\n\
                  <div style=\"float:left;width:160px;vertical-align:top;\" >\n\
                    <b>Activities and Societies:</b>\n\
                  </div>\n\
                  <div style=\"float: right; width:350px;\">\n\
                    <textarea cols=\"55\" id=\"education_"+window.formIndex+"_activities\" name=\"education["+window.formIndex+"][activities]\" rows=\"7\"></textarea>\n\
                  </div>\n\
                  <div style=\"clear:both;\"></div>\n\
                </p>\n\
                <p>\n\
                  <div style=\"float:left;width:150px;vertical-align:top;\" ><b>Additional Notes:</b></div>\n\
                  <div style=\"float: right; width:350px;\">\n\
                    <textarea cols=\"55\" id=\"education_"+window.formIndex+"_description\" name=\"education["+window.formIndex+"][description]\" rows=\"7\"></textarea>\n\
                  </div>\n\
                  <div style=\"clear:both;\"></div>\n\
                </p>\n\
                <p>\n\
                  <a href=\"#\" onclick=\"$(this).up('.education_field').remove();$$('.education_field').length == 0 ? $('cancel_add_education').click() : false;; return false;\">remove</a>\n\
                </p>\n\
              </div>"
  });
  return false;
}

function addNewExperienceMultipleForm() {
  window.experienceFormIndex = window.experienceFormIndex + 1;
  Element.insert("experience_fields", {
    bottom: "<div class=\"experience_field\">\n\
      <p></p>\n\
      <div style=\"float:left;width:110px;\"><b>Company name:</b></div>\n\
      <span style=\"display: none\" id=\"experience_company_name_cant_be_blank_"+window.experienceFormIndex+"\">\n\
        <div style=\"float: right; width:390px; color: red\">Company name can't be blank</div>\n\
      </span>\n\
      <div style=\"float: right; width:390px;\">\n\
        <input type=\"text\" onchange=\"validateFieldCantBeBlank('experience_"+window.experienceFormIndex+"_company_name', 'experience_company_name_cant_be_blank_"+window.experienceFormIndex+"')\" name=\"experience["+window.experienceFormIndex+"][company_name]\" id=\"experience_"+window.experienceFormIndex+"_company_name\">\n\
      </div>\n\
      <div style=\"clear:both;\"></div>\n\
      <p></p><p></p>\n\
      <div style=\"float:left;width:110px;\"><b>Company url:</b></div>\n\
      <span id=\"experience_company_url_not_valid_"+window.experienceFormIndex+"\" style=\"display: none\">\n\
        <div style=\"float: right; width:350px; color: red\">You have entered an invalid link.</div>\n\
      </span>\n\
      <div style=\"float: right; width:390px;\">\n\
        <input type=\"text\" name=\"experience["+window.experienceFormIndex+"][company_url]\" id=\"experience_"+window.experienceFormIndex+"_company_url\" onchange=\"validateURLAddress('experience_"+window.experienceFormIndex+"_company_url', 'experience_company_url_not_valid_"+window.experienceFormIndex+"')\">\n\
      </div>\n\
      <div style=\"clear:both;\"></div>\n\
      <p></p><p></p>\n\
      <div style=\"float:left;width:110px;\"><b>Title:</b></div>\n\
      <span style=\"display: none\" id=\"experience_title_cant_be_blank_"+window.experienceFormIndex+"\">\n\
        <div style=\"float: right; width:390px; color: red\">Title can't be blank</div>\n\
      </span>\n\
      <div style=\"float: right; width:390px;\">\n\
        <input type=\"text\" onchange=\"validateFieldCantBeBlank('experience_"+window.experienceFormIndex+"_title', 'experience_title_cant_be_blank_"+window.experienceFormIndex+"')\" name=\"experience["+window.experienceFormIndex+"][title]\" id=\"experience_"+window.experienceFormIndex+"_title\">\n\
      </div>\n\
      <div style=\"clear:both;\"></div>\n\
      <p></p><p></p>\n\
      <div style=\"float:left;width:110px;display:inline;\"><b>Time Period:</b></div>\n\
      <span id=\"experience_start_month_cant_be_blank_"+window.experienceFormIndex+"\" style=\"display: none\">\n\
        <div style=\"float:right;width:390px;color: red\">Please select a start month.</div>\n\
      </span>\n\
      <span id=\"experience_end_month_cant_be_blank_"+window.experienceFormIndex+"\" style=\"display: none\">\n\
        <div style=\"float:right;width:390px;color: red\">Please select an end month.</div>\n\
      </span>\n\
      <span style=\"display: none\" id=\"experience_year_must_enter_after_1900_"+window.experienceFormIndex+"\">\n\
        <div style=\"float:right;width:390px;color: red\">Please enter a year after 1900.</div>\n\
      </span>\n\
      <span id=\"experience_end_year_must_enter_after_1900_"+window.experienceFormIndex+"\" style=\"display: none\">\n\
        <div style=\"float:right;width:390px;color: red\">Please enter an end year after 1900.</div>\n\
      </span>\n\
      <span style=\"display: none\" id=\"experience_end_year_must_greater_than_start_year_"+window.experienceFormIndex+"\">\n\
        <div style=\"float:right;width:390px;color: red\">End year must equal or greater than start year.</div>\n\
      </span>\n\
      <div style=\"float: right; width:390px;\">\n\
        <input type=\"checkbox\" value=\"1\" onclick=\"toggleDatePresent(this.checked, "+window.experienceFormIndex+")\" name=\"experience["+window.experienceFormIndex+"][current]\" id=\"experience_"+window.experienceFormIndex+"_current\"> I currently work here<br>\n\
        <select name=\"experience["+window.experienceFormIndex+"][from_month]\" id=\"experience_"+window.experienceFormIndex+"_from_month\" onchange=\"validateFieldCantBeBlank('experience_"+window.experienceFormIndex+"_from_month', 'experience_start_month_cant_be_blank_"+window.experienceFormIndex+"')\">\n\
          <option value=\"\">Select</option>\n\
          <option value=\"1\">January</option>\n\
          <option value=\"2\">February</option>\n\
          <option value=\"3\">March</option>\n\
          <option value=\"4\">April</option>\n\
          <option value=\"5\">May</option>\n\
          <option value=\"6\">June</option>\n\
          <option value=\"7\">July</option>\n\
          <option value=\"8\">August</option>\n\
          <option value=\"9\">September</option>\n\
          <option value=\"10\">October</option>\n\
          <option value=\"11\">November</option>\n\
          <option value=\"12\">December</option>\n\
        </select>\n\
        <input type=\"text\" size=\"4\" onchange=\"validateBetweenFromAndEndYear('experience_"+window.experienceFormIndex+"_from_year', 'experience_"+window.experienceFormIndex+"_end_year', $('experience_"+window.experienceFormIndex+"_current').checked, 'start year', 'experience_year_must_enter_after_1900_"+window.experienceFormIndex+"', 'experience_end_year_must_greater_than_start_year_"+window.experienceFormIndex+"', 'experience_end_year_must_enter_after_1900_"+window.experienceFormIndex+"', 'experience_start_month_cant_be_blank_"+window.experienceFormIndex+"', 'experience_end_month_cant_be_blank_"+window.experienceFormIndex+"', 'experience_"+window.experienceFormIndex+"_from_month', 'experience_"+window.experienceFormIndex+"_end_month')\" name=\"experience["+window.experienceFormIndex+"][from_year]\" maxlength=\"4\" id=\"experience_"+window.experienceFormIndex+"_from_year\">\n\
        to\n\
        <span style=\"display:inline; \" id=\"to_"+window.experienceFormIndex+"\">\n\
        <select name=\"experience["+window.experienceFormIndex+"][end_month]\" id=\"experience_"+window.experienceFormIndex+"_end_month\" onchange=\"validateFieldCantBeBlank('experience_"+window.experienceFormIndex+"_end_month', 'experience_end_month_cant_be_blank_"+window.experienceFormIndex+"')\">\n\
          <option value=\"\">Select</option>\n\
          <option value=\"1\">January</option>\n\
          <option value=\"2\">February</option>\n\
          <option value=\"3\">March</option>\n\
          <option value=\"4\">April</option>\n\
          <option value=\"5\">May</option>\n\
          <option value=\"6\">June</option>\n\
          <option value=\"7\">July</option>\n\
          <option value=\"8\">August</option>\n\
          <option value=\"9\">September</option>\n\
          <option value=\"10\">October</option>\n\
          <option value=\"11\">November</option>\n\
          <option value=\"12\">December</option>\n\
        </select>\n\
        <input type=\"text\" size=\"4\" onchange=\"validateBetweenFromAndEndYear('experience_"+window.experienceFormIndex+"_from_year', 'experience_"+window.experienceFormIndex+"_end_year', $('experience_"+window.experienceFormIndex+"_current').checked, 'end year', 'experience_year_must_enter_after_1900_"+window.experienceFormIndex+"', 'experience_end_year_must_greater_than_start_year_"+window.experienceFormIndex+"', 'experience_end_year_must_enter_after_1900_"+window.experienceFormIndex+"', 'experience_start_month_cant_be_blank_"+window.experienceFormIndex+"', 'experience_end_month_cant_be_blank_"+window.experienceFormIndex+"', 'experience_"+window.experienceFormIndex+"_from_month', 'experience_"+window.experienceFormIndex+"_end_month')\" name=\"experience["+window.experienceFormIndex+"][end_year]\" maxlength=\"4\" id=\"experience_"+window.experienceFormIndex+"_end_year\">\n\
      </span>\n\
      <span style=\"display:none; \" id=\"to_current_"+window.experienceFormIndex+"\">Present</span>\n\
    </div>\n\
    <div style=\"clear:both;\"></div>\n\
    <p></p><p></p>\n\
    <div style=\"float:left;width:110px;vertical-align:top;\"><b>Description:</b></div>\n\
    <div style=\"float: right; width:390px;\">\n\
      <textarea rows=\"7\" name=\"experience["+window.experienceFormIndex+"][description]\" id=\"experience_"+window.experienceFormIndex+"_description\" cols=\"55\"></textarea>\n\
    </div>\n\
    <div style=\"clear:both;\"></div>\n\
    <p></p>\n\
    <p>\n\
      <a onclick=\"$(this).up('.experience_field').remove();$$('.experience_field').length == 0 ? $('cancel_add_experience').click() : false;; return false;\" href=\"#\">remove</a>\n\
    </p>\n\
  </div>"
  });
  return false;
}

function addNewUserSkillMultipleForm()  {
  window.userSkillFormIndex = window.userSkillFormIndex + 1;
  Element.insert("skill_fields", {
    bottom: "<div class=\"skill_field\">\n\
              <input type=\"hidden\" name=\"user_skill["+window.userSkillFormIndex+"][skill_id]\" id=\"user_skill_"+window.userSkillFormIndex+"_skill_id\">\n\
              <p></p>\n\
              <div style=\"float:left;width:150px;\"><b>Title:</b></div>\n\
              <span style=\"display: none\" id=\"user_skill_title_cant_be_blank_"+window.userSkillFormIndex+"\">\n\
              <div style=\"float: right; width:350px; color: red\">Title can't be blank</div>\n\
              </span>\n\
              <span id=\"user_skill_title_been_taken_"+window.userSkillFormIndex+"\" style=\"display: none\">\n\
                <div style=\"float: right; width:350px; color: red\">Title has been taken</div>\n\
              </span>\n\
              <div style=\"float: right; width:350px;\">\n\
                <input type=\"text\" onfocus=\"window.currentTitleFocused = "+window.userSkillFormIndex+"\" onblur=\"window.currentTitleFocused = -1\" onchange=\"validateFieldCantBeBlank('user_skill_"+window.userSkillFormIndex+"_title', 'user_skill_title_cant_be_blank_"+window.userSkillFormIndex+"')\" name=\"user_skill_"+window.userSkillFormIndex+"_title\" id=\"user_skill_"+window.userSkillFormIndex+"_title\">\n\
                <span style=\"display: none;\" id=\"add_new_skill_ajax_loader_"+window.userSkillFormIndex+"\">\n\
                  <img alt=\"Loadericon\" src=\"/images/LoaderIcon.gif\" style=\"width:15px\">\n\
                </span>\n\
          </div>\n\
              <div style=\"clear:both;\"></div>\n\
              <p></p><p></p>\n\
              <div style=\"float:left;width:150px;\"><b>Description:</b></div>\n\
              <span style=\"display: none\" id=\"user_skill_description_cant_be_blank_"+window.userSkillFormIndex+"\">\n\
                <div style=\"float: right; width:350px; color: red\">Description can't be blank</div>\n\
              </span>\n\
              <div style=\"float: right; width:350px;\">\n\
                <textarea rows=\"4\" onchange=\"validateFieldCantBeBlank('user_skill_"+window.userSkillFormIndex+"_description', 'user_skill_description_cant_be_blank_"+window.userSkillFormIndex+"')\" name=\"user_skill["+window.userSkillFormIndex+"][description]\" id=\"user_skill_"+window.userSkillFormIndex+"_description\"></textarea>\n\
              </div>\n\
              <div style=\"clear:both;\"></div>\n\
              <p></p><p></p>\n\
              <div style=\"float:left;width:150px;\"><b>Time Period:</b></div>\n\
              <span style=\"display: none\" id=\"user_skill_year_or_month_cant_be_blank_"+window.userSkillFormIndex+"\">\n\
                <div style=\"float: right; width:350px; color: red\">Year or month can't be blank</div>\n\
              </span>\n\
              <span style=\"display: none\" id=\"user_skill_year_must_integer_"+window.userSkillFormIndex+"\"><div style=\"float: right; width:350px; color: red\">Year must be integer</div></span>\n\
              <span style=\"display: none\" id=\"user_skill_year_must_greater_than_zero_"+window.userSkillFormIndex+"\"><div style=\"float: right; width:350px; color: red\">Year must greater than 0</div></span>\n\
              <span style=\"display: none\" id=\"user_skill_month_must_integer_"+window.userSkillFormIndex+"\"><div style=\"float: right; width:350px; color: red\">Month must be integer</div></span>\n\
              <span style=\"display: none\" id=\"user_skill_month_must_greater_than_zero_"+window.userSkillFormIndex+"\"><div style=\"float: right; width:350px; color: red\">Month must greater than 0</div></span>\n\
              <div style=\"float: right; width:350px;\">\n\
                <input type=\"text\" size=\"4\" onchange=\"valueMustInteger('user_skill_"+window.userSkillFormIndex+"_year_period', 'user_skill_year_must_integer_"+window.userSkillFormIndex+"', 'user_skill_year_must_greater_than_zero_"+window.userSkillFormIndex+"')\" name=\"user_skill["+window.userSkillFormIndex+"][year_period]\" maxlength=\"4\" id=\"user_skill_"+window.userSkillFormIndex+"_year_period\"> years\n\
                <input type=\"text\" size=\"1\" onchange=\"valueMustInteger('user_skill_"+window.userSkillFormIndex+"_month_period', 'user_skill_month_must_integer_"+window.userSkillFormIndex+"', 'user_skill_month_must_greater_than_zero_"+window.userSkillFormIndex+"')\" name=\"user_skill["+window.userSkillFormIndex+"][month_period]\" maxlength=\"1\" id=\"user_skill_"+window.userSkillFormIndex+"_month_period\"> months\n\
              </div>\n\
              <div style=\"clear:both;\"></div>\n\
              <p></p>\n\
              <p>\n\
                <a onclick=\"$(this).up('.skill_field').remove();$$('.skill_field').length == 0 ? $('cancel_add_skill').click() : false;; return false;\" href=\"#\">remove</a>\n\
              </p>\n\
            </div>"
  });
  new Autocomplete('user_skill_'+window.userSkillFormIndex+'_title', {
    serviceUrl:'/user_skills/suggestion/search_skill'
  });
  
  return false;
}

function addNewInterestMultipleForm() {
  window.interestFormIndex = window.interestFormIndex + 1;
  Element.insert("interest_fields", {
    bottom: "<div class=\"interest_field\">\n\
              <p></p>\n\
              <div style=\"float:left;width:150px;\"><b>Name:</b></div>\n\
              <span style=\"display: none\" id=\"interest_name_cant_be_blank_"+window.interestFormIndex+"\">\n\
                <div style=\"float: right; width:350px; color: red\">Name can't be blank</div>\n\
              </span>\n\
              <span style=\"display: none\" id=\"interest_name_must_unique_"+window.interestFormIndex+"\">\n\
                <div style=\"float: right; width:350px; color: red\">Name must be uniqueness</div>\n\
              </span>\n\
              <div style=\"float: right; width:350px;\">\n\
                <input type=\"text\" onchange=\"validateFieldCantBeBlank('interest_"+window.interestFormIndex+"_name', 'interest_name_cant_be_blank_"+window.interestFormIndex+"')\" name=\"interest["+window.interestFormIndex+"][name]\" id=\"interest_"+window.interestFormIndex+"_name\">\n\
              </div>\n\
              <div style=\"clear:both;\"></div>\n\
              <p></p>\n\
              <p>\n\
                <a onclick=\"$(this).up('.interest_field').remove();$$('.interest_field').length == 0 ? $('cancel_add_interest').click() : false;; return false;\" href=\"#\">remove</a>\n\
              </p>\n\
             </div>"
  });
  return false;
}

function validateURLAddress(elementId, messageErrorElementId) {
  if(trim($(elementId).value) == "" || trim($(elementId).value) == null)  {
    $(messageErrorElementId).hide();
    return true;
  }
  else  {
    var RegExp = /(http|https):\/\/(\w+:{0,1}\w*@)?(\S+)(:[0-9]+)?(\/|\/([\w#!:.?+=&%@!\-\/]))?/;
    if(RegExp.test(trim($(elementId).value)) == false)  {
      if((trim($(elementId).value).indexOf("http://") < 0 || trim($(elementId).value).indexOf("https://") < 0)
        && trim($(elementId).value).indexOf(".") >= 0) {
        $(messageErrorElementId).hide();
        return true;
      }
      else  {
        $(messageErrorElementId).show();
        return false;
      }
    }
    else  {
      $(messageErrorElementId).hide();
      return true;
    }
  }
}

function addNewCertificationMultipleForm() {
  window.certificationFormIndex = window.certificationFormIndex + 1;
  Element.insert("certification_fields", {
    bottom: "<div class=\"certification_field\">\n\
              <p></p>\n\
              <div style=\"float:left;width:150px;\"><b>Title:</b></div>\n\
              <span style=\"display: none\" id=\"certification_title_cant_be_blank_"+window.certificationFormIndex+"\">\n\
                <div style=\"float: right; width:350px; color: red\">Title can't be blank</div>\n\
              </span>\n\
              <span style=\"display: none\" id=\"certification_title_must_unique_"+window.certificationFormIndex+"\">\n\
                <div style=\"float: right; width:350px; color: red\">Title must be uniqueness</div>\n\
              </span>\n\
              <div style=\"float: right; width:350px;\">\n\
                <input type=\"text\" onchange=\"validateFieldCantBeBlank('certification_"+window.certificationFormIndex+"_title', 'certification_title_cant_be_blank_"+window.certificationFormIndex+"')\" name=\"certification["+window.certificationFormIndex+"][title]\" id=\"certification_"+window.certificationFormIndex+"_title\">\n\
              </div>\n\
              <div style=\"clear:both;\"></div>\n\
              <p></p><p></p>\n\
              <div style=\"float:left;width:160px;\"><b>Award date:</b></div>\n\
              <span id=\"certification_month_cant_be_blank_"+window.certificationFormIndex+"\" style=\"display: none\">\n\
                <div style=\"float:right;width:350px;color: red\">Please select a month.</div>\n\
              </span>\n\
              <span style=\"display: none\" id=\"certification_year_must_enter_after_1900_"+window.certificationFormIndex+"\">\n\
                <div style=\"float:right;width:350px;color: red\">Please enter a year after 1900.</div>\n\
              </span>\n\
              <div style=\"float: right; width:350px;\">\n\
                <input type=\"hidden\" value=\"\" name=\"certification["+window.certificationFormIndex+"][award_date(1i)]\" id=\"certification_"+window.certificationFormIndex+"_award_date_1i\">\n\
                <input type=\"hidden\" name=\"certification["+window.certificationFormIndex+"][award_date(3i)]\" id=\"certification_"+window.certificationFormIndex+"_award_date_3i\">\n\
                <select name=\"certification["+window.certificationFormIndex+"][award_date(2i)]\" id=\"certification_"+window.certificationFormIndex+"_award_date_2i\" onchange=\"validateFieldCantBeBlank('certification_"+window.certificationFormIndex+"_award_date_2i', 'certification_month_cant_be_blank_"+window.certificationFormIndex+"')\">\n\
                <option value=\"\">Month</option>\n\
                <option value=\"1\">January</option>\n\
                <option value=\"2\">February</option>\n\
                  <option value=\"3\">March</option>\n\
<option value=\"4\">April</option>\n\
<option value=\"5\">May</option>\n\
<option value=\"6\">June</option>\n\
<option value=\"7\">July</option>\n\
<option value=\"8\">August</option>\n\
<option value=\"9\">September</option>\n\
<option value=\"10\">October</option>\n\
<option value=\"11\">November</option>\n\
<option value=\"12\">December</option>\n\
</select>\n\
        <input type=\"text\" size=\"4\" onchange=\"validateSingleYear('certification_"+window.certificationFormIndex+"_award_year', 'certification_year_must_enter_after_1900_"+window.certificationFormIndex+"', 'certification_month_cant_be_blank_"+window.certificationFormIndex+"', 'after filled field')\" name=\"certification["+window.certificationFormIndex+"][award_year]\" maxlength=\"4\" id=\"certification_"+window.certificationFormIndex+"_award_year\">\n\
      </div>\n\
        <div style=\"clear:both;\"></div>\n\
          <p></p>\n\
          <p>\n\
          <a onclick=\"$(this).up('.certification_field').remove();$$('.certification_field').length == 0 ? $('cancel_add_certification').click() : false;; return false;\" href=\"#\">remove</a>\n\
        </p>\n\
      </div>"
  });
  return false;
}

function addNewMembershipMultipleForm() {
  window.membershipFormIndex = window.membershipFormIndex + 1;
  Element.insert("membership_fields", {
    bottom: "<div class=\"membership_field\">\n\
              <p></p>\n\
              <div style=\"float:left;width:150px;\"><b>Name:</b></div>\n\
              <span style=\"display: none\" id=\"membership_name_cant_be_blank_"+window.membershipFormIndex+"\">\n\
                <div style=\"float: right; width:350px; color: red\">Name can't be blank</div>\n\
              </span>\n\
              <span style=\"display: none\" id=\"membership_name_must_unique_"+window.membershipFormIndex+"\">\n\
      <div style=\"float: right; width:350px; color: red\">Name must be uniqueness</div>\n\
              </span>\n\
              <div style=\"float: right; width:350px;\">\n\
                <input type=\"text\" onchange=\"validateFieldCantBeBlank('membership_"+window.membershipFormIndex+"_name', 'membership_name_cant_be_blank_"+window.membershipFormIndex+"')\" name=\"membership["+window.membershipFormIndex+"][name]\" id=\"membership_"+window.membershipFormIndex+"_name\">\n\
              </div>\n\
              <div style=\"clear:both;\"></div>\n\
              <p></p><p></p>\n\
              <div style=\"float:left;width:150px;\"><b>Time Period:</b></div>\n\
              <span style=\"display: none\" id=\"membership_start_month_cant_be_blank_"+window.membershipFormIndex+"\"><div style=\"float:right;width:350px;color: red\">Please select a start month.</div></span>\n\
        <span style=\"display: none\" id=\"membership_end_month_cant_be_blank_"+window.membershipFormIndex+"\"><div style=\"float:right;width:350px;color: red\">Please select an end month.</div></span>\n\
        <span style=\"display: none\" id=\"membership_year_must_enter_after_1900_"+window.membershipFormIndex+"\"><div style=\"float:right;width:350px;color: red\">Please enter a start year after 1900.</div></span>\n\
        <span style=\"display: none\" id=\"membership_end_year_must_enter_after_1900_"+window.membershipFormIndex+"\"><div style=\"float:right;width:350px;color: red\">Please enter an end year after 1900.</div></span>\n\
        <span style=\"display: none\" id=\"membership_end_year_must_greater_than_start_year_"+window.membershipFormIndex+"\"><div style=\"float:right;width:350px;color: red\">End year must equal or greater than start year.</div></span>\n\
        <div style=\"float: right; width:350px;\">\n\
          <input type=\"checkbox\" value=\"1\" onclick=\"dateToPresent(this.checked, "+window.membershipFormIndex+")\" name=\"membership["+window.membershipFormIndex+"][to_present]\" id=\"membership_"+window.membershipFormIndex+"_to_present\"> I currently active\n\
        </div>\n\
        <div style=\"clear:both;\"></div>\n\
        <div style=\"float: right; width:350px;\">\n\
          <input type=\"hidden\" value=\"\" name=\"membership["+window.membershipFormIndex+"][from_date(1i)]\" id=\"membership_"+window.membershipFormIndex+"_from_date_1i\">\n\
<input type=\"hidden\" name=\"membership["+window.membershipFormIndex+"][from_date(3i)]\" id=\"membership_"+window.membershipFormIndex+"_from_date_3i\">\n\
<select onchange=\"validateFieldCantBeBlank('membership_"+window.membershipFormIndex+"_from_date_2i', 'membership_start_month_cant_be_blank_"+window.membershipFormIndex+"')\" name=\"membership["+window.membershipFormIndex+"][from_date(2i)]\" id=\"membership_"+window.membershipFormIndex+"_from_date_2i\">\n\
<option value=\"\">Month</option>\n\
<option value=\"1\">January</option>\n\
<option value=\"2\">February</option>\n\
<option value=\"3\">March</option>\n\
<option value=\"4\">April</option>\n\
<option value=\"5\">May</option>\n\
<option value=\"6\">June</option>\n\
<option value=\"7\">July</option>\n\
<option value=\"8\">August</option>\n\
<option value=\"9\">September</option>\n\
<option value=\"10\">October</option>\n\
<option value=\"11\">November</option>\n\
<option value=\"12\">December</option>\n\
</select>\n\
    <input type=\"text\" size=\"4\" onchange=\"validateBetweenFromAndEndYear('membership_"+window.membershipFormIndex+"_from_year', 'membership_"+window.membershipFormIndex+"_until_year', $('membership_"+window.membershipFormIndex+"_to_present').checked, 'start year', 'membership_year_must_enter_after_1900_"+window.membershipFormIndex+"', 'membership_end_year_must_greater_than_start_year_"+window.membershipFormIndex+"', 'membership_end_year_must_enter_after_1900_"+window.membershipFormIndex+"', 'membership_start_month_cant_be_blank_"+window.membershipFormIndex+"', 'membership_end_month_cant_be_blank_"+window.membershipFormIndex+"', 'membership_"+window.membershipFormIndex+"_from_date_2i', 'membership_"+window.membershipFormIndex+"_until_date_2i')\" name=\"membership["+window.membershipFormIndex+"][from_year]\" maxlength=\"4\" id=\"membership_"+window.membershipFormIndex+"_from_year\">\n\
          to\n\
          <span id=\"until-date-form-"+window.membershipFormIndex+"\">\n\
            <input type=\"hidden\" value=\"\" name=\"membership["+window.membershipFormIndex+"][until_date(1i)]\" id=\"membership_"+window.membershipFormIndex+"_until_date_1i\">\n\
<input type=\"hidden\" name=\"membership["+window.membershipFormIndex+"][until_date(3i)]\" id=\"membership_"+window.membershipFormIndex+"_until_date_3i\">\n\
<select onchange=\"validateFieldCantBeBlank('membership_"+window.membershipFormIndex+"_until_date_2i', 'membership_end_month_cant_be_blank_"+window.membershipFormIndex+"')\" name=\"membership["+window.membershipFormIndex+"][until_date(2i)]\" id=\"membership_"+window.membershipFormIndex+"_until_date_2i\">\n\
<option value=\"\">Month</option>\n\
<option value=\"1\">January</option>\n\
<option value=\"2\">February</option>\n\
<option value=\"3\">March</option>\n\
<option value=\"4\">April</option>\n\
<option value=\"5\">May</option>\n\
<option value=\"6\">June</option>\n\
<option value=\"7\">July</option>\n\
<option value=\"8\">August</option>\n\
<option value=\"9\">September</option>\n\
<option value=\"10\">October</option>\n\
<option value=\"11\">November</option>\n\
<option value=\"12\">December</option>\n\
</select>\n\
            <input type=\"text\" size=\"4\" onchange=\"validateBetweenFromAndEndYear('membership_"+window.membershipFormIndex+"_from_year', 'membership_"+window.membershipFormIndex+"_until_year', $('membership_"+window.membershipFormIndex+"_to_present').checked, 'end year', 'membership_year_must_enter_after_1900_"+window.membershipFormIndex+"', 'membership_end_year_must_greater_than_start_year_"+window.membershipFormIndex+"', 'membership_end_year_must_enter_after_1900_"+window.membershipFormIndex+"', 'membership_start_month_cant_be_blank_"+window.membershipFormIndex+"', 'membership_end_month_cant_be_blank_"+window.membershipFormIndex+"', 'membership_"+window.membershipFormIndex+"_from_date_2i', 'membership_"+window.membershipFormIndex+"_until_date_2i')\" name=\"membership["+window.membershipFormIndex+"][until_year]\" maxlength=\"4\" id=\"membership_"+window.membershipFormIndex+"_until_year\">\n\
          </span>\n\
          <span style=\"display: none\" id=\"present-date-"+window.membershipFormIndex+"\">Present</span>\n\
        </div>\n\
        <div style=\"clear:both;\"></div>\n\
        <p></p>\n\
        <p>\n\
          <a onclick=\"$(this).up('.membership_field').remove();$$('.membership_field').length == 0 ? $('cancel_add_membership').click() : false;; return false;\" href=\"#\">remove</a>\n\
        </p>\n\
      </div>"
  });
  return false;
}
