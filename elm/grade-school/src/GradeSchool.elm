module GradeSchool exposing (addStudent, allStudents, empty, studentsInGrade)

import Dict exposing (Dict)


type alias Grade =
    Int


type alias Student =
    String


type alias School =
    Dict Grade (List Student)


empty : School
empty =
    Dict.empty


addStudent : Grade -> Student -> School -> School
addStudent grade student school =
    let
        students =
            student :: studentsInGrade grade school

        sortedStudents =
            List.sort students
    in
    Dict.insert grade sortedStudents school


studentsInGrade : Grade -> School -> List Student
studentsInGrade grade school =
    Dict.get grade school
        |> Maybe.withDefault []


allStudents : School -> List ( Grade, List Student )
allStudents school =
    Dict.toList school
        |> List.sort
