INCLUDE Irvine32.inc
INCLUDELIB Irvine32.lib

.data
    ; Flight structure (200 bytes per flight)
    MAX_FLIGHTS EQU 50
    MAX_TICKETS EQU 100
    MAX_COMPLAINTS EQU 50
    
    ; Flight data arrays
    flightNumbers       BYTE MAX_FLIGHTS DUP(10 DUP(?))     ; Flight numbers
    airlines            BYTE MAX_FLIGHTS DUP(20 DUP(?))     ; Airline names
    sources             BYTE MAX_FLIGHTS DUP(20 DUP(?))     ; Source cities
    destinations        BYTE MAX_FLIGHTS DUP(20 DUP(?))     ; Destination cities
    departureTimes      BYTE MAX_FLIGHTS DUP(10 DUP(?))     ; Departure times
    arrivalTimes        BYTE MAX_FLIGHTS DUP(10 DUP(?))     ; Arrival times
    flightDates         BYTE MAX_FLIGHTS DUP(12 DUP(?))     ; Flight dates
    flightPrices        DWORD MAX_FLIGHTS DUP(?)            ; Flight prices
    totalSeats          DWORD MAX_FLIGHTS DUP(?)            ; Total seats
    availableSeats      DWORD MAX_FLIGHTS DUP(?)            ; Available seats
    flightActive        BYTE MAX_FLIGHTS DUP(?)             ; Active flag (1=active, 0=deleted)
    flightCount         DWORD 0
    
    ; Ticket data arrays
    ticketIDs           DWORD MAX_TICKETS DUP(?)            ; Ticket IDs
    ticketFlightNums    BYTE MAX_TICKETS DUP(10 DUP(?))     ; Flight numbers for tickets
    customerNames       BYTE MAX_TICKETS DUP(30 DUP(?))     ; Customer names
    customerPhones      BYTE MAX_TICKETS DUP(15 DUP(?))     ; Customer phones
    customerEmails      BYTE MAX_TICKETS DUP(50 DUP(?))     ; Customer emails
    ticketPrices        DWORD MAX_TICKETS DUP(?)            ; Ticket prices
    ticketActive        BYTE MAX_TICKETS DUP(?)             ; Ticket status
    ticketCount         DWORD 0
    nextTicketID        DWORD 1001
    
    ; Complaint data arrays
    complaintIDs        DWORD MAX_COMPLAINTS DUP(?)         ; Complaint IDs
    complaintCategories BYTE MAX_COMPLAINTS DUP(20 DUP(?))  ; Categories
    complaintDetails    BYTE MAX_COMPLAINTS DUP(200 DUP(?)) ; Complaint details
    complaintNames      BYTE MAX_COMPLAINTS DUP(30 DUP(?))  ; Customer names
    complaintResponses  BYTE MAX_COMPLAINTS DUP(200 DUP(?)) ; Admin responses
    complaintStatus     BYTE MAX_COMPLAINTS DUP(?)          ; Status (0=pending, 1=resolved)
    complaintCount      DWORD 0
    nextComplaintID     DWORD 5001
    
    ; Menu strings
    mainMenuTitle       BYTE "=== AIRPORT TICKETING & COMPLAINT SYSTEM ===", 0dh, 0ah, 0
    mainMenu            BYTE "1. Admin Panel", 0dh, 0ah
                        BYTE "2. Book Ticket", 0dh, 0ah
                        BYTE "3. View My Tickets", 0dh, 0ah
                        BYTE "4. Cancel Ticket", 0dh, 0ah
                        BYTE "5. File Complaint", 0dh, 0ah
                        BYTE "6. View Available Flights", 0dh, 0ah
                        BYTE "7. Search Ticket", 0dh, 0ah
                        BYTE "0. Exit", 0dh, 0ah
                        BYTE "Enter choice: ", 0
    
    adminMenuTitle      BYTE "=== ADMIN PANEL ===", 0dh, 0ah, 0
    adminMenu           BYTE "1. Add Flight", 0dh, 0ah
                        BYTE "2. View All Flights", 0dh, 0ah
                        BYTE "3. Update Flight", 0dh, 0ah
                        BYTE "4. Delete Flight", 0dh, 0ah
                        BYTE "5. View Complaints", 0dh, 0ah
                        BYTE "6. Respond to Complaint", 0dh, 0ah
                        BYTE "0. Back to Main Menu", 0dh, 0ah
                        BYTE "Enter choice: ", 0
    
    ; Input prompts
    promptFlightNum     BYTE "Enter Flight Number: ", 0
    promptAirline       BYTE "Enter Airline: ", 0
    promptSource        BYTE "Enter Source City: ", 0
    promptDestination   BYTE "Enter Destination City: ", 0
    promptDepartTime    BYTE "Enter Departure Time (HH:MM): ", 0
    promptArriveTime    BYTE "Enter Arrival Time (HH:MM): ", 0
    promptDate          BYTE "Enter Date (DD/MM/YYYY): ", 0
    promptPrice         BYTE "Enter Price: $", 0
    promptSeats         BYTE "Enter Total Seats: ", 0
    promptName          BYTE "Enter Your Name: ", 0
    promptPhone         BYTE "Enter Phone Number: ", 0
    promptEmail         BYTE "Enter Email: ", 0
    promptTicketID      BYTE "Enter Ticket ID: ", 0
    promptComplaintCat  BYTE "Enter Complaint Category (Delay/Service/Baggage/Other): ", 0
    promptComplaintDet  BYTE "Enter Complaint Details: ", 0
    promptComplaintID   BYTE "Enter Complaint ID: ", 0
    promptResponse      BYTE "Enter Response: ", 0
    
    ; Messages
    msgFlightAdded      BYTE "Flight added successfully!", 0dh, 0ah, 0
    msgFlightUpdated    BYTE "Flight updated successfully!", 0dh, 0ah, 0
    msgFlightDeleted    BYTE "Flight deleted successfully!", 0dh, 0ah, 0
    msgFlightNotFound   BYTE "Flight not found!", 0dh, 0ah, 0
    msgTicketBooked     BYTE "Ticket booked successfully! Your Ticket ID: ", 0
    msgTicketCanceled   BYTE "Ticket canceled successfully!", 0dh, 0ah, 0
    msgTicketNotFound   BYTE "Ticket not found!", 0dh, 0ah, 0
    msgNoSeats          BYTE "No seats available!", 0dh, 0ah, 0
    msgComplaintFiled   BYTE "Complaint filed successfully! Your Complaint ID: ", 0
    msgNoFlights        BYTE "No flights available!", 0dh, 0ah, 0
    msgNoTickets        BYTE "No tickets found!", 0dh, 0ah, 0
    msgNoComplaints     BYTE "No complaints found!", 0dh, 0ah, 0
    msgInvalidChoice    BYTE "Invalid choice! Please try again.", 0dh, 0ah, 0
    msgPressEnter       BYTE "Press Enter to continue...", 0
    msgComplaintUpdated BYTE "Complaint response added successfully!", 0dh, 0ah, 0
    msgFileError        BYTE "Error accessing file!", 0dh, 0ah, 0
    
    ; Headers
    headerFlights       BYTE "Flight# | Airline     | Source      | Destination | Date       | Time  | Price | Seats", 0dh, 0ah
                        BYTE "--------|-------------|-------------|-------------|------------|-------|-------|------", 0dh, 0ah, 0
    headerTickets       BYTE "Ticket ID | Flight# | Name         | Phone      | Price", 0dh, 0ah
                        BYTE "----------|---------|--------------|------------|------", 0dh, 0ah, 0
    headerComplaints    BYTE "ID   | Category | Customer     | Status  | Details", 0dh, 0ah
                        BYTE "-----|----------|--------------|---------|--------", 0dh, 0ah, 0
    
    ; Temporary input buffers
    tempBuffer          BYTE 200 DUP(?)
    tempNumber          DWORD ?
    tempChoice          DWORD ?
    
    ; Admin password
    adminPassword       BYTE "admin123", 0
    inputPassword       BYTE 20 DUP(?)
    promptPassword      BYTE "Enter admin password: ", 0
    msgWrongPassword    BYTE "Wrong password!", 0dh, 0ah, 0
    
    newline             BYTE 0dh, 0ah, 0
    space               BYTE " ", 0
    pipe                BYTE " | ", 0
    dollar              BYTE "$", 0
    statusPending       BYTE "Pending", 0
    statusResolved      BYTE "Resolved", 0
    
    ; File handling variables
    flightsFile         BYTE "flights.dat", 0
    ticketsFile         BYTE "tickets.dat", 0
    complaintsFile      BYTE "complaints.dat", 0
    fileHandle          HANDLE ?
    bytesWritten        DWORD ?
    bytesRead           DWORD ?

.code
main PROC
    call Clrscr
    
    ; Load data from files at startup
    call loadFlightsFromFile
    call loadTicketsFromFile
    call loadComplaintsFromFile
    
MainLoop:
    call ShowMainMenu
    call ReadDec
    mov tempChoice, eax
    
    cmp eax, 0
    je ExitProgram
    cmp eax, 1
    je AdminPanel
    cmp eax, 2
    je BookTicket
    cmp eax, 3
    je ViewMyTickets
    cmp eax, 4
    je CancelTicket
    cmp eax, 5
    je FileComplaint
    cmp eax, 6
    je ViewAvailableFlights
    cmp eax, 7
    je SearchTicket
    
    ; Invalid choice
    mov edx, OFFSET msgInvalidChoice
    call WriteString
    call MyWaitMsg
    jmp MainLoop

AdminPanel:
    call CheckAdminPassword
    cmp eax, 0
    je MainLoop
    call ShowAdminMenu
    jmp MainLoop

BookTicket:
    call BookFlightTicket
    jmp MainLoop

ViewMyTickets:
    call ViewTicketHistory
    jmp MainLoop

CancelTicket:
    call CancelFlightTicket
    jmp MainLoop

FileComplaint:
    call FileCustomerComplaint
    jmp MainLoop

ViewAvailableFlights:
    call DisplayAvailableFlights
    jmp MainLoop

SearchTicket:
    call SearchTicketByID
    jmp MainLoop

ExitProgram:
    ; Save data to files before exiting
    call saveFlightsToFile
    call saveTicketsToFile
    call saveComplaintsToFile
    exit
main ENDP

; Save flights to file
saveFlightsToFile PROC
    push eax
    push edx
    push ecx
    
    ; Open file for writing
    mov edx, OFFSET flightsFile
    call CreateOutputFile
    cmp eax, -1
    je FileError
    mov fileHandle, eax
    
    ; Write flightCount (DWORD)
    mov eax, fileHandle
    mov edx, OFFSET flightCount
    mov ecx, 4
    call WriteToFile
    
    ; Write flightNumbers
    mov eax, fileHandle
    mov edx, OFFSET flightNumbers
    mov ecx, MAX_FLIGHTS * 10
    call WriteToFile
    
    ; Write airlines
    mov eax, fileHandle
    mov edx, OFFSET airlines
    mov ecx, MAX_FLIGHTS * 20
    call WriteToFile
    
    ; Write sources
    mov eax, fileHandle
    mov edx, OFFSET sources
    mov ecx, MAX_FLIGHTS * 20
    call WriteToFile
    
    ; Write destinations
    mov eax, fileHandle
    mov edx, OFFSET destinations
    mov ecx, MAX_FLIGHTS * 20
    call WriteToFile
    
    ; Write departureTimes
    mov eax, fileHandle
    mov edx, OFFSET departureTimes
    mov ecx, MAX_FLIGHTS * 10
    call WriteToFile
    
    ; Write arrivalTimes
    mov eax, fileHandle
    mov edx, OFFSET arrivalTimes
    mov ecx, MAX_FLIGHTS * 10
    call WriteToFile
    
    ; Write flightDates
    mov eax, fileHandle
    mov edx, OFFSET flightDates
    mov ecx, MAX_FLIGHTS * 12
    call WriteToFile
    
    ; Write flightPrices
    mov eax, fileHandle
    mov edx, OFFSET flightPrices
    mov ecx, MAX_FLIGHTS * 4
    call WriteToFile
    
    ; Write totalSeats
    mov eax, fileHandle
    mov edx, OFFSET totalSeats
    mov ecx, MAX_FLIGHTS * 4
    call WriteToFile
    
    ; Write availableSeats
    mov eax, fileHandle
    mov edx, OFFSET availableSeats
    mov ecx, MAX_FLIGHTS * 4
    call WriteToFile
    
    ; Write flightActive
    mov eax, fileHandle
    mov edx, OFFSET flightActive
   mov ecx, MAX_FLIGHTS
    call WriteToFile
    
    ; Close file
    mov eax, fileHandle
    call CloseFile
    
    jmp SaveFlightsEnd

FileError:
    mov edx, OFFSET msgFileError
    call WriteString
    call MyWaitMsg

SaveFlightsEnd:
    pop ecx
    pop edx
    pop eax
    ret
saveFlightsToFile ENDP

; Load flights from file
loadFlightsFromFile PROC
    push eax
    push edx
    push ecx
    push edi
    
    ; Open file for reading
    mov edx, OFFSET flightsFile
    call OpenInputFile
    cmp eax, -1
    je InitializeEmptyFlights
    mov fileHandle, eax
    
    ; Read flightCount
    mov eax, fileHandle
    mov edx, OFFSET flightCount
    mov ecx, 4
    call ReadFromFile
    
    ; Read flightNumbers
    mov eax, fileHandle
    mov edx, OFFSET flightNumbers
    mov ecx, MAX_FLIGHTS * 10
    call ReadFromFile
    
    ; Read airlines
    mov eax, fileHandle
    mov edx, OFFSET airlines
    mov ecx, MAX_FLIGHTS * 20
    call ReadFromFile
    
    ; Read sources
    mov eax, fileHandle
    mov edx, OFFSET sources
    mov ecx, MAX_FLIGHTS * 20
    call ReadFromFile
    
    ; Read destinations
    mov eax, fileHandle
    mov edx, OFFSET destinations
    mov ecx, MAX_FLIGHTS * 20
    call ReadFromFile
    
    ; Read departureTimes
    mov eax, fileHandle
    mov edx, OFFSET departureTimes
    mov ecx, MAX_FLIGHTS * 10
    call ReadFromFile
    
    ; Read arrivalTimes
    mov eax, fileHandle
    mov edx, OFFSET arrivalTimes
    mov ecx, MAX_FLIGHTS * 10
    call ReadFromFile
    
    ; Read flightDates
    mov eax, fileHandle
    mov edx, OFFSET flightDates
    mov ecx, MAX_FLIGHTS * 12
    call ReadFromFile
    
    ; Read flightPrices
    mov eax, fileHandle
    mov edx, OFFSET flightPrices
    mov ecx, MAX_FLIGHTS * 4
    call ReadFromFile
    
    ; Read totalSeats
    mov eax, fileHandle
    mov edx, OFFSET totalSeats
    mov ecx, MAX_FLIGHTS * 4
    call ReadFromFile
    
    ; Read availableSeats
    mov eax, fileHandle
    mov edx, OFFSET availableSeats
    mov ecx, MAX_FLIGHTS * 4
    call ReadFromFile
    
    ; Read flightActive
    mov eax, fileHandle
    mov edx, OFFSET flightActive
    mov ecx, MAX_FLIGHTS
    call ReadFromFile
    
    ; Close file
    mov eax, fileHandle
    call CloseFile
    jmp LoadFlightsEnd

InitializeEmptyFlights:
    ; Initialize flight data to empty
    mov flightCount, 0
    mov ecx, MAX_FLIGHTS
    mov edi, OFFSET flightActive
    xor al, al
    rep stosb ; Clear flightActive array
    ; Other arrays are not cleared as they’ll be overwritten when adding flights

LoadFlightsEnd:
    pop edi
    pop ecx
    pop edx
    pop eax
    ret
loadFlightsFromFile ENDP

; Save tickets to file
saveTicketsToFile PROC
    push eax
    push edx
    push ecx
    
    ; Open file for writing
    mov edx, OFFSET ticketsFile
    call CreateOutputFile
    cmp eax, -1
    je FileError
    mov fileHandle, eax
    
    ; Write ticketCount
    mov eax, fileHandle
    mov edx, OFFSET ticketCount
    mov ecx, 4
    call WriteToFile
    
    ; Write nextTicketID
    mov eax, fileHandle
    mov edx, OFFSET nextTicketID
    mov ecx, 4
    call WriteToFile
    
    ; Write ticketIDs
    mov eax, fileHandle
    mov edx, OFFSET ticketIDs
    mov ecx, MAX_TICKETS * 4
    call WriteToFile
    
    ; Write ticketFlightNums
    mov eax, fileHandle
    mov edx, OFFSET ticketFlightNums
    mov ecx, MAX_TICKETS * 10
    call WriteToFile
    
    ; Write customerNames
    mov eax, fileHandle
    mov edx, OFFSET customerNames
    mov ecx, MAX_TICKETS * 30
    call WriteToFile
    
    ; Write customerPhones
    mov eax, fileHandle
    mov edx, OFFSET customerPhones
    mov ecx, MAX_TICKETS * 15
    call WriteToFile
    
    ; Write customerEmails
    mov eax, fileHandle
    mov edx, OFFSET customerEmails
    mov ecx, MAX_TICKETS * 50
    call WriteToFile
    
    ; Write ticketPrices
    mov eax, fileHandle
    mov edx, OFFSET ticketPrices
    mov ecx, MAX_TICKETS * 4
    call WriteToFile
    
    ; Write ticketActive
    mov eax, fileHandle
    mov edx, OFFSET ticketActive
    mov ecx, MAX_TICKETS
    call WriteToFile
    
    ; Close file
    mov eax, fileHandle
    call CloseFile
    
    jmp SaveTicketsEnd

FileError:
    mov edx, OFFSET msgFileError
    call WriteString
    call MyWaitMsg

SaveTicketsEnd:
    pop ecx
    pop edx
    pop eax
    ret
saveTicketsToFile ENDP

; Load tickets from file
loadTicketsFromFile PROC
    push eax
    push edx
    push ecx
    push edi
    
    ; Open file for reading
    mov edx, OFFSET ticketsFile
    call OpenInputFile
    cmp eax, -1
    je InitializeEmptyTickets
    mov fileHandle, eax
    
    ; Read ticketCount
    mov eax, fileHandle
    mov edx, OFFSET ticketCount
    mov ecx, 4
    call ReadFromFile
    
    ; Read nextTicketID
    mov eax, fileHandle
    mov edx, OFFSET nextTicketID
    mov ecx, 4
    call ReadFromFile
    
    ; Read ticketIDs
    mov eax, fileHandle
    mov edx, OFFSET ticketIDs
    mov ecx, MAX_TICKETS * 4
    call ReadFromFile
    
    ; Read ticketFlightNums
    mov eax, fileHandle
    mov edx, OFFSET ticketFlightNums
    mov ecx, MAX_TICKETS * 10
    call ReadFromFile
    
    ; Read customerNames
    mov eax, fileHandle
    mov edx, OFFSET customerNames
    mov ecx, MAX_TICKETS * 30
    call ReadFromFile
    
    ; Read customerPhones
    mov eax, fileHandle
    mov edx, OFFSET customerPhones
    mov ecx, MAX_TICKETS * 15
    call ReadFromFile
    
    ; Read customerEmails
    mov eax, fileHandle
    mov edx, OFFSET customerEmails
    mov ecx, MAX_TICKETS * 50
    call ReadFromFile
    
    ; Read ticketPrices
    mov eax, fileHandle
    mov edx, OFFSET ticketPrices
    mov ecx, MAX_TICKETS * 4
    call ReadFromFile
    
    ; Read ticketActive
    mov eax, fileHandle
    mov edx, OFFSET ticketActive
    mov ecx, MAX_TICKETS
    call ReadFromFile
    
    ; Close file
    mov eax, fileHandle
    call CloseFile
    jmp LoadTicketsEnd

InitializeEmptyTickets:
    ; Initialize ticket data to empty
    mov ticketCount, 0
    mov nextTicketID, 1001
    mov ecx, MAX_TICKETS
    mov edi, OFFSET ticketActive
    xor al, al
    rep stosb ; Clear ticketActive array

LoadTicketsEnd:
    pop edi
    pop ecx
    pop edx
    pop eax
    ret
loadTicketsFromFile ENDP

; Save complaints to file
saveComplaintsToFile PROC
    push eax
    push edx
    push ecx
    
    ; Open file for writing
    mov edx, OFFSET complaintsFile
    call CreateOutputFile
    cmp eax, -1
    je FileError
    mov fileHandle, eax
    
    ; Write complaintCount
    mov eax, fileHandle
    mov edx, OFFSET complaintCount
    mov ecx, 4
    call WriteToFile
    
    ; Write nextComplaintID
    mov eax, fileHandle
    mov edx, OFFSET nextComplaintID
    mov ecx, 4
    call WriteToFile
    
    ; Write complaintIDs
    mov eax, fileHandle
    mov edx, OFFSET complaintIDs
    mov ecx, MAX_COMPLAINTS * 4
    call WriteToFile
    
    ; Write complaintCategories
    mov eax, fileHandle
    mov edx, OFFSET complaintCategories
    mov ecx, MAX_COMPLAINTS * 20
    call WriteToFile
    
    ; Write complaintNames
    mov eax, fileHandle
    mov edx, OFFSET complaintNames
    mov ecx, MAX_COMPLAINTS * 30
    call WriteToFile
    
    ; Write complaintDetails
    mov eax, fileHandle
    mov edx, OFFSET complaintDetails
    mov ecx, MAX_COMPLAINTS * 200
    call WriteToFile
    
    ; Write complaintResponses
    mov eax, fileHandle
    mov edx, OFFSET complaintResponses
    mov ecx, MAX_COMPLAINTS * 200
    call WriteToFile
    
    ; Write complaintStatus
    mov eax, fileHandle
    mov edx, OFFSET complaintStatus
    mov ecx, MAX_COMPLAINTS
    call WriteToFile
    
    ; Close file
    mov eax, fileHandle
    call CloseFile
    
    jmp SaveComplaintsEnd

FileError:
    mov edx, OFFSET msgFileError
    call WriteString
    call MyWaitMsg

SaveComplaintsEnd:
    pop ecx
    pop edx
    pop eax
    ret
saveComplaintsToFile ENDP

; Load complaints from file
loadComplaintsFromFile PROC
    push eax
    push edx
    push ecx
    push edi
    
    ; Open file for reading
    mov edx, OFFSET complaintsFile
    call OpenInputFile
    cmp eax, -1
    je InitializeEmptyComplaints
    mov fileHandle, eax
    
    ; Read complaintCount
    mov eax, fileHandle
    mov edx, OFFSET complaintCount
    mov ecx, 4
    call ReadFromFile
    
    ; Read nextComplaintID
    mov eax, fileHandle
    mov edx, OFFSET nextComplaintID
    mov ecx, 4
    call ReadFromFile
    
    ; Read complaintIDs
    mov eax, fileHandle
    mov edx, OFFSET complaintIDs
    mov ecx, MAX_COMPLAINTS * 4
    call ReadFromFile
    
    ; Read complaintCategories
    mov eax, fileHandle
    mov edx, OFFSET complaintCategories
    mov ecx, MAX_COMPLAINTS * 20
    call ReadFromFile
    
    ; Read complaintNames
    mov eax, fileHandle
    mov edx, OFFSET complaintNames
    mov ecx, MAX_COMPLAINTS * 30
    call ReadFromFile
    
    ; Read complaintDetails
    mov eax, fileHandle
    mov edx, OFFSET complaintDetails
    mov ecx, MAX_COMPLAINTS * 200
    call ReadFromFile
    
    ; Read complaintResponses
    mov eax, fileHandle
    mov edx, OFFSET complaintResponses
    mov ecx, MAX_COMPLAINTS * 200
    call ReadFromFile
    
    ; Read complaintStatus
    mov eax, fileHandle
    mov edx, OFFSET complaintStatus
    mov ecx, MAX_COMPLAINTS
    call ReadFromFile
    
    ; Close file
    mov eax, fileHandle
    call CloseFile
    jmp LoadComplaintsEnd

InitializeEmptyComplaints:
    ; Initialize complaint data to empty
    mov complaintCount, 0
    mov nextComplaintID, 5001
    mov ecx, MAX_COMPLAINTS
    mov edi, OFFSET complaintStatus
    xor al, al
    rep stosb ; Clear complaintStatus array

LoadComplaintsEnd:
    pop edi
    pop ecx
    pop edx
    pop eax
    ret
loadComplaintsFromFile ENDP

; Existing procedures (unchanged, included for completeness)
ShowMainMenu PROC
    call Clrscr
    mov edx, OFFSET mainMenuTitle
    call WriteString
    mov edx, OFFSET mainMenu
    call WriteString
    ret
ShowMainMenu ENDP

CheckAdminPassword PROC
    mov edx, OFFSET promptPassword
    call WriteString
    mov edx, OFFSET inputPassword
    mov ecx, SIZEOF inputPassword
    call ReadString
    
    mov esi, OFFSET inputPassword
    mov edi, OFFSET adminPassword
    mov ecx, 8
    repe cmpsb
    je PasswordCorrect
    
    mov edx, OFFSET msgWrongPassword
    call WriteString
    call MyWaitMsg
    mov eax, 0
    ret
    
PasswordCorrect:
    mov eax, 1
    ret
CheckAdminPassword ENDP

ShowAdminMenu PROC
AdminMenuLoop:
    call Clrscr
    mov edx, OFFSET adminMenuTitle
    call WriteString
    mov edx, OFFSET adminMenu
    call WriteString
    call ReadDec
    
    cmp eax, 0
    je AdminMenuExit
    cmp eax, 1
    je AddFlight
    cmp eax, 2
    je ViewAllFlights
    cmp eax, 3
    je UpdateFlight
    cmp eax, 4
    je DeleteFlight
    cmp eax, 5
    je ViewComplaints
    cmp eax, 6
    je RespondComplaint
    
    mov edx, OFFSET msgInvalidChoice
    call WriteString
    call MyWaitMsg
    jmp AdminMenuLoop

AddFlight:
    call AddNewFlight
    jmp AdminMenuLoop

ViewAllFlights:
    call DisplayAllFlights
    jmp AdminMenuLoop

UpdateFlight:
    call UpdateFlightDetails
    jmp AdminMenuLoop

DeleteFlight:
    call DeleteFlightRecord
    jmp AdminMenuLoop

ViewComplaints:
    call DisplayComplaints
    jmp AdminMenuLoop

RespondComplaint:
    call RespondToComplaint
    jmp AdminMenuLoop

AdminMenuExit:
    ret
ShowAdminMenu ENDP

AddNewFlight PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi
    
    mov eax, flightCount
    cmp eax, MAX_FLIGHTS
    jae FlightLimitReached
    
    call Clrscr
    mov edx, OFFSET promptFlightNum
    call WriteString
    
    mov eax, flightCount
    mov ebx, 10
    mul ebx
    mov edi, eax
    add edi, OFFSET flightNumbers
    
    mov edx, edi
    mov ecx, 10
    call ReadString
    
    mov edx, OFFSET promptAirline
    call WriteString
    mov eax, flightCount
    mov ebx, 20
    mul ebx
    mov edi, eax
    add edi, OFFSET airlines
    mov edx, edi
    mov ecx, 20
    call ReadString
    
    mov edx, OFFSET promptSource
    call WriteString
    mov eax, flightCount
    mov ebx, 20
    mul ebx
    mov edi, eax
    add edi, OFFSET sources
    mov edx, edi
    mov ecx, 20
    call ReadString
    
    mov edx, OFFSET promptDestination
    call WriteString
    mov eax, flightCount
    mov ebx, 20
    mul ebx
    mov edi, eax
    add edi, OFFSET destinations
    mov edx, edi
    mov ecx, 20
    call ReadString
    
    mov edx, OFFSET promptDepartTime
    call WriteString
    mov eax, flightCount
    mov ebx, 10
    mul ebx
    mov edi, eax
    add edi, OFFSET departureTimes
    mov edx, edi
    mov ecx, 10
    call ReadString
    
    mov edx, OFFSET promptArriveTime
    call WriteString
    mov eax, flightCount
    mov ebx, 10
    mul ebx
    mov edi, eax
    add edi, OFFSET arrivalTimes
    mov edx, edi
    mov ecx, 10
    call ReadString
    
    mov edx, OFFSET promptDate
    call WriteString
    mov eax, flightCount
    mov ebx, 12
    mul ebx
    mov edi, eax
    add edi, OFFSET flightDates
    mov edx, edi
    mov ecx, 12
    call ReadString
    
    mov edx, OFFSET promptPrice
    call WriteString
    call ReadDec
    mov ebx, flightCount
    mov flightPrices[ebx*4], eax
    
    mov edx, OFFSET promptSeats
    call WriteString
    call ReadDec
    mov ebx, flightCount
    mov totalSeats[ebx*4], eax
    mov availableSeats[ebx*4], eax
    
    mov ebx, flightCount
    mov flightActive[ebx], 1
    
    inc flightCount
    
    mov edx, OFFSET msgFlightAdded
    call WriteString
    call MyWaitMsg
    jmp AddFlightEnd

FlightLimitReached:
    mov edx, OFFSET msgNoFlights
    call WriteString
    call MyWaitMsg

AddFlightEnd:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
AddNewFlight ENDP

DisplayAllFlights PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    call Clrscr
    mov edx, OFFSET headerFlights
    call WriteString
    
    mov ecx, flightCount
    cmp ecx, 0
    je NoFlightsToShow
    
    mov esi, 0
    
DisplayFlightLoop:
    cmp flightActive[esi], 1
    jne SkipFlight
    
    mov eax, esi
    mov ebx, 10
    mul ebx
    add eax, OFFSET flightNumbers
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    mov eax, esi
    mov ebx, 20
    mul ebx
    add eax, OFFSET airlines
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    mov eax, esi
    mov ebx, 20
    mul ebx
    add eax, OFFSET sources
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    mov eax, esi
    mov ebx, 20
    mul ebx
    add eax, OFFSET destinations
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    mov eax, esi
    mov ebx, 12
    mul ebx
    add eax, OFFSET flightDates
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    mov eax, esi
    mov ebx, 10
    mul ebx
    add eax, OFFSET departureTimes
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    mov edx, OFFSET dollar
    call WriteString
    mov eax, flightPrices[esi*4]
    call WriteDec
    mov edx, OFFSET pipe
    call WriteString
    
    mov eax, availableSeats[esi*4]
    call WriteDec
    mov edx, OFFSET newline
    call WriteString

SkipFlight:
    inc esi
    dec ecx
jnz DisplayFlightLoop
    
    call MyWaitMsg
    jmp DisplayFlightsEnd

NoFlightsToShow:
    mov edx, OFFSET msgNoFlights
    call WriteString
    call MyWaitMsg

DisplayFlightsEnd:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
DisplayAllFlights ENDP

DisplayAvailableFlights PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    call Clrscr
    mov edx, OFFSET headerFlights
    call WriteString
    
    mov ecx, flightCount
    cmp ecx, 0
    je NoAvailableFlights
    
    mov esi, 0
    
DisplayAvailableLoop:
    cmp flightActive[esi], 1
    jne SkipAvailableFlight
    cmp availableSeats[esi*4], 0
    je SkipAvailableFlight
    
    mov eax, esi
    mov ebx, 10
    mul ebx
    add eax, OFFSET flightNumbers
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    mov eax, esi
    mov ebx, 20
    mul ebx
    add eax, OFFSET airlines
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    mov eax, esi
    mov ebx, 20
    mul ebx
    add eax, OFFSET sources
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    mov eax, esi
    mov ebx, 20
    mul ebx
    add eax, OFFSET destinations
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    mov eax, esi
    mov ebx, 12
    mul ebx
    add eax, OFFSET flightDates
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    mov eax, esi
    mov ebx, 10
    mul ebx
    add eax, OFFSET departureTimes
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    mov edx, OFFSET dollar
    call WriteString
    mov eax, flightPrices[esi*4]
    call WriteDec
    mov edx, OFFSET pipe
    call WriteString
    
    mov eax, availableSeats[esi*4]
    call WriteDec
    mov edx, OFFSET newline
    call WriteString

SkipAvailableFlight:
    inc esi
    dec ecx
jnz DisplayAvailableLoop
    
    call MyWaitMsg
    jmp DisplayAvailableEnd

NoAvailableFlights:
    mov edx, OFFSET msgNoFlights
    call WriteString
    call MyWaitMsg

DisplayAvailableEnd:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
DisplayAvailableFlights ENDP

BookFlightTicket PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi
    
    call DisplayAvailableFlights
    
    mov eax, ticketCount
    cmp eax, MAX_TICKETS
    jae TicketLimitReached
    
    mov edx, OFFSET promptFlightNum
    call WriteString
    mov edx, OFFSET tempBuffer
    mov ecx, SIZEOF tempBuffer
    call ReadString
    
    call FindFlightByNumber
    cmp eax, -1
    jne L_BookTicket_Continue_537
    jmp FlightNotFoundForBooking
L_BookTicket_Continue_537:
    
    mov ebx, eax
    cmp availableSeats[ebx*4], 0
    je NoSeatsAvailable
    
    mov edx, OFFSET promptName
    call WriteString
    mov eax, ticketCount
    imul eax, eax, 30
    add eax, OFFSET customerNames
    mov edx, eax
    mov ecx, 30
    call ReadString
    
    mov edx, OFFSET promptPhone
    call WriteString
    mov eax, ticketCount
    imul eax, eax, 15
    add eax, OFFSET customerPhones
    mov edx, eax
    mov ecx, 15
    call ReadString
    
    mov edx, OFFSET promptEmail
    call WriteString
    mov eax, ticketCount
    imul eax, eax, 50
    add eax, OFFSET customerEmails
    mov edx, eax
    mov ecx, 50
    call ReadString
    
    mov eax, nextTicketID
    mov ebx, ticketCount
    mov ticketIDs[ebx*4], eax
    inc nextTicketID
    
    mov esi, OFFSET tempBuffer
    mov eax, ticketCount
    imul eax, eax, 10
    add eax, OFFSET ticketFlightNums
    mov edi, eax
    mov ecx, 10
    rep movsb
    
    call FindFlightByNumber
    mov ebx, eax
    mov eax, flightPrices[ebx*4]
    mov ebx, ticketCount
    mov ticketPrices[ebx*4], eax
    mov ticketActive[ebx], 1
    
    call FindFlightByNumber
    mov ebx, eax
    dec availableSeats[ebx*4]
    
    inc ticketCount
    
    mov edx, OFFSET msgTicketBooked
    call WriteString
    mov eax, ticketCount
    dec eax
    imul eax, eax, 4
    mov eax, ticketIDs[eax]
    call WriteDec
    mov edx, OFFSET newline
    call WriteString
    call MyWaitMsg
    jmp BookTicketEnd

FlightNotFoundForBooking:
    mov edx, OFFSET msgFlightNotFound
    call WriteString
    call MyWaitMsg
    jmp BookTicketEnd

NoSeatsAvailable:
    mov edx, OFFSET msgNoSeats
    call WriteString
    call MyWaitMsg
    jmp BookTicketEnd

TicketLimitReached:
    mov edx, OFFSET msgNoTickets
    call WriteString
    call MyWaitMsg

BookTicketEnd:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
BookFlightTicket ENDP

FindFlightByNumber PROC
    push ebx
    push ecx
    push edx
    push esi
    push edi
    
    mov ecx, flightCount
    cmp ecx, 0
    je FlightNotFoundInSearch_DirectExit
    
    mov esi, 0
    
FindFlightLoop:
    cmp flightActive[esi], 1
    jne NextFlightSearch
    
    push esi
    mov eax, esi
    mov ebx, 10
    mul ebx
    add eax, OFFSET flightNumbers
    mov edi, eax
    mov esi, OFFSET tempBuffer
    push ecx
    mov ecx, 10
    repe cmpsb
    pop ecx
    pop esi
    je FlightFoundInSearch
    
NextFlightSearch:
    inc esi
    mov eax, esi
    cmp eax, flightCount
    jl FindFlightLoop

FlightNotFoundInSearch_DirectExit:
    mov eax, -1
    jmp FindFlightEnd

FlightFoundInSearch:
    mov eax, esi
FindFlightEnd:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret
FindFlightByNumber ENDP

ViewTicketHistory PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    call Clrscr
    mov edx, OFFSET headerTickets
    call WriteString
    
    mov ecx, ticketCount
    cmp ecx, 0
    je NoTicketsToShow
    
    mov esi, 0
    
ViewTicketLoop:
    cmp ticketActive[esi], 1
    jne SkipTicket
    
    mov eax, ticketIDs[esi*4]
    call WriteDec
    mov edx, OFFSET pipe
    call WriteString
    
    mov eax, esi
    mov ebx, 10
    mul ebx
    add eax, OFFSET ticketFlightNums
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    mov eax, esi
    mov ebx, 30
    mul ebx
    add eax, OFFSET customerNames
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    mov eax, esi
    mov ebx, 15
    mul ebx
    add eax, OFFSET customerPhones
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    mov edx, OFFSET dollar
    call WriteString
    mov eax, ticketPrices[esi*4]
    call WriteDec
    mov edx, OFFSET newline
    call WriteString

SkipTicket:
    inc esi
    dec ecx
jnz ViewTicketLoop
    
    call MyWaitMsg
    jmp ViewTicketEnd

NoTicketsToShow:
    mov edx, OFFSET msgNoTickets
    call WriteString
    call MyWaitMsg

ViewTicketEnd:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
ViewTicketHistory ENDP

CancelFlightTicket PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    mov edx, OFFSET promptTicketID
    call WriteString
    call ReadDec
    mov tempNumber, eax
    
    mov ecx, ticketCount
    cmp ecx, 0
    jne L_CancelTicket_Continue_650
    jmp TicketNotFoundForCancel
L_CancelTicket_Continue_650:
    
    mov esi, 0
    
FindTicketLoop_Cancel:
    mov eax, ticketIDs[esi*4]
    cmp eax, tempNumber
    je TicketFoundForCancel
    inc esi
    loop FindTicketLoop_Cancel
    jmp TicketNotFoundForCancel

TicketNotFoundForCancel:
    mov edx, OFFSET msgTicketNotFound
    call WriteString
    call MyWaitMsg
    jmp CancelTicketEnd

TicketFoundForCancel:
    cmp ticketActive[esi], 0
    je TicketNotFoundForCancel
    
    mov ticketActive[esi], 0
    
    push edi
    mov eax, esi
    imul eax, eax, 10
    add eax, OFFSET ticketFlightNums
    mov edi, OFFSET tempBuffer
    push esi
    mov esi, eax
    push ecx
    mov ecx, 10
    rep movsb
    pop ecx
    pop esi
    pop edi
    
    call FindFlightByNumber
    cmp eax, -1
    je TicketCancelSuccess
    mov ebx, eax
    inc availableSeats[ebx*4]
    
TicketCancelSuccess:
    mov edx, OFFSET msgTicketCanceled
    call WriteString
    call MyWaitMsg

CancelTicketEnd:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
CancelFlightTicket ENDP

SearchTicketByID PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    mov edx, OFFSET promptTicketID
    call WriteString
    call ReadDec
    mov tempNumber, eax
    
    mov ecx, ticketCount
    cmp ecx, 0
    jne L_SearchTicket_Continue_921
    jmp TicketNotFoundForSearch
L_SearchTicket_Continue_921:
    
    mov esi, 0
    
SearchTicketLoop_ByID:
    mov eax, ticketIDs[esi*4]
    cmp eax, tempNumber
    je TicketFoundForSearch
    inc esi
    loop SearchTicketLoop_ByID
    jmp TicketNotFoundForSearch

TicketNotFoundForSearch:
    mov edx, OFFSET msgTicketNotFound
    call WriteString
    call MyWaitMsg
    jmp SearchTicketEnd

TicketFoundForSearch:
    cmp ticketActive[esi], 0
    je TicketNotFoundForSearch
    
    call Clrscr
    mov edx, OFFSET headerTickets
    call WriteString
    
    mov eax, ticketIDs[esi*4]
    call WriteDec
    mov edx, OFFSET pipe
    call WriteString
    
    mov eax, esi
    mov ebx, 10
    mul ebx
    add eax, OFFSET ticketFlightNums
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    mov eax, esi
    mov ebx, 30
    mul ebx
    add eax, OFFSET customerNames
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    mov eax, esi
    mov ebx, 15
    mul ebx
    add eax, OFFSET customerPhones
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    mov edx, OFFSET dollar
    call WriteString
    mov eax, ticketPrices[esi*4]
    call WriteDec
    mov edx, OFFSET newline
    call WriteString
    
    call MyWaitMsg

SearchTicketEnd:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
SearchTicketByID ENDP

FileCustomerComplaint PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi
    
    mov eax, complaintCount
    cmp eax, MAX_COMPLAINTS
    jae ComplaintLimitReached
    
    call Clrscr
    
    mov edx, OFFSET promptName
    call WriteString
    mov eax, complaintCount
    imul eax, eax, 30
    add eax, OFFSET complaintNames
    mov edx, eax
    mov ecx, 30
    call ReadString
    
    mov edx, OFFSET promptComplaintCat
    call WriteString
    mov eax, complaintCount
    imul eax, eax, 20
    add eax, OFFSET complaintCategories
    mov edx, eax
    mov ecx, 20
    call ReadString
    
    mov edx, OFFSET promptComplaintDet
    call WriteString
    mov eax, complaintCount
    imul eax, eax, 200
    add eax, OFFSET complaintDetails
    mov edx, eax
    mov ecx, 200
    call ReadString
    
    mov eax, nextComplaintID
    mov ebx, complaintCount
    mov complaintIDs[ebx*4], eax
    inc nextComplaintID
    mov complaintStatus[ebx], 0
    
    mov eax, complaintCount
    imul eax, eax, 200
    add eax, OFFSET complaintResponses
    mov edi, eax
    push ecx
    mov ecx, 200
    mov al, 0
    rep stosb
    pop ecx
    
    inc complaintCount
    
    mov edx, OFFSET msgComplaintFiled
    call WriteString
    mov eax, complaintCount
    dec eax
    imul eax, eax, 4
    mov eax, complaintIDs[eax]
    call WriteDec
    mov edx, OFFSET newline
    call WriteString
    call MyWaitMsg
    jmp FileComplaintEnd

ComplaintLimitReached:
    mov edx, OFFSET msgNoComplaints
    call WriteString
    call MyWaitMsg

FileComplaintEnd:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
FileCustomerComplaint ENDP

DisplayComplaints PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    call Clrscr
    mov edx, OFFSET headerComplaints
    call WriteString
    
    mov ecx, complaintCount
    cmp ecx, 0
    je NoComplaintsToShow
    
    mov esi, 0
    
DisplayComplaintLoop:
    mov eax, complaintIDs[esi*4]
    call WriteDec
    mov edx, OFFSET pipe
    call WriteString
    
    mov eax, esi
    mov ebx, 20
    mul ebx
    add eax, OFFSET complaintCategories
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    mov eax, esi
    mov ebx, 30
    mul ebx
    add eax, OFFSET complaintNames
    mov edx, eax
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    cmp complaintStatus[esi], 0
    je ShowPending
    mov edx, OFFSET statusResolved
    jmp ShowStatus
ShowPending:
    mov edx, OFFSET statusPending
ShowStatus:
    call WriteString
    mov edx, OFFSET pipe
    call WriteString
    
    mov eax, esi
    mov ebx, 200
    mul ebx
    add eax, OFFSET complaintDetails
    mov edx, eax
    call WriteString
    mov edx, OFFSET newline
    call WriteString
    
    inc esi
    dec ecx
jnz DisplayComplaintLoop
    
    call MyWaitMsg
    jmp DisplayComplaintsEnd

NoComplaintsToShow:
    mov edx, OFFSET msgNoComplaints
    call WriteString
    call MyWaitMsg

DisplayComplaintsEnd:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
DisplayComplaints ENDP

RespondToComplaint PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    mov edx, OFFSET promptComplaintID
    call WriteString
    call ReadDec
    mov tempNumber, eax
    
    mov ecx, complaintCount
    cmp ecx, 0
    je FindComplaintNotFound
    
    mov esi, 0
    
FindComplaintSearchLoop:
    mov eax, complaintIDs[esi*4]
    cmp eax, tempNumber
    je FindComplaintFound
    inc esi
    loop FindComplaintSearchLoop
    jmp FindComplaintNotFound
    
FindComplaintNotFound:
    mov edx, OFFSET msgNoComplaints
    call WriteString
    call MyWaitMsg
    jmp RespondComplaintEnd

FindComplaintFound:
    mov edx, OFFSET promptResponse
    call WriteString
    mov eax, esi
    mov ebx, 200
    mul ebx
    add eax, OFFSET complaintResponses
    mov edx, eax
    mov ecx, 200
    call ReadString
    
    mov complaintStatus[esi], 1
    
    mov edx, OFFSET msgComplaintUpdated
    call WriteString
    call MyWaitMsg

RespondComplaintEnd:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
RespondToComplaint ENDP

UpdateFlightDetails PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi
    
    mov edx, OFFSET promptFlightNum
    call WriteString
    mov edx, OFFSET tempBuffer
    mov ecx, SIZEOF tempBuffer
    call ReadString
    
    call FindFlightByNumber
    cmp eax, -1
    jne L_UpdateFlight_Continue_1272
    jmp FlightNotFoundForUpdate
L_UpdateFlight_Continue_1272:
    
    mov esi, eax
    
    mov edx, OFFSET promptPrice
    call WriteString
    call ReadDec
    mov flightPrices[esi*4], eax
    
    mov edx, OFFSET promptDepartTime
    call WriteString
    mov eax, esi
    mov ebx, 10
    mul ebx
    add eax, OFFSET departureTimes
    mov edx, eax
    mov ecx, 10
    call ReadString
    
    mov edx, OFFSET msgFlightUpdated
    call WriteString
    call MyWaitMsg
    jmp UpdateFlightEnd

FlightNotFoundForUpdate:
    mov edx, OFFSET msgFlightNotFound
    call WriteString
    call MyWaitMsg

UpdateFlightEnd:
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
UpdateFlightDetails ENDP

DeleteFlightRecord PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    mov edx, OFFSET promptFlightNum
    call WriteString
    mov edx, OFFSET tempBuffer
    mov ecx, SIZEOF tempBuffer
    call ReadString
    
    call FindFlightByNumber
    cmp eax, -1
    je FlightNotFoundForDelete
    
    mov esi, eax
    mov flightActive[esi], 0
    
    mov edx, OFFSET msgFlightDeleted
    call WriteString
    call MyWaitMsg
    jmp DeleteFlightEnd

FlightNotFoundForDelete:
    mov edx, OFFSET msgFlightNotFound
    call WriteString
    call MyWaitMsg

DeleteFlightEnd:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
DeleteFlightRecord ENDP

MyWaitMsg PROC
    push edx
    mov edx, OFFSET msgPressEnter
    call WriteString
    call ReadChar
    pop edx
    ret
MyWaitMsg ENDP

END main
