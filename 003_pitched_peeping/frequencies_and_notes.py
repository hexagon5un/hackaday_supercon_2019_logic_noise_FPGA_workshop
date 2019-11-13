## 8 MHz clock, what divisors give us what pitches?


def pitch_divisors(freq):
    p = 8000000 / 2 / freq    
    return p

def midi_note_to_pitch(n):
    pitch = 440 * 2**((n-69)/12.0)
    return pitch

notes = ["A", "A#" , "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#"]

w = open("frequencies_and_notes.txt", "w")
w.write('divisor, \tMIDI note - piano key\n')
for note in range(21,109):
    increment = round(pitch_divisors(midi_note_to_pitch(note)))
    notename = notes[(note-21)%12] + str(int((note-12)/12)) 
    comment = "     /* " + str(int(note)) + " - " + notename + " */\n"
    w.write(str(increment) + ", " + comment )
w.write("};\n")


