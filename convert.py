from kivy.app import App
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.label import Label
from kivy.uix.textinput import TextInput
from kivy.uix.button import Button

DIGITS = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"

def convert(num_str, from_base, to_base):
    num_str = num_str.strip().upper()
    decimal_value = 0
    for ch in num_str:
        decimal_value = decimal_value * from_base + DIGITS.index(ch)

    if decimal_value == 0:
        return "0"
    result = ""
    while decimal_value > 0:
        result = DIGITS[decimal_value % to_base] + result
        decimal_value //= to_base
    return result


class ConverterUI(BoxLayout):
    def __init__(self, **kwargs):
        super().__init__(orientation="vertical", **kwargs)

        self.input_number = TextInput(hint_text="Enter number", multiline=False)
        self.add_widget(self.input_number)

        self.from_base = TextInput(hint_text="From base (2–36)", multiline=False)
        self.add_widget(self.from_base)

        self.to_base = TextInput(hint_text="To base (2–36)", multiline=False)
        self.add_widget(self.to_base)

        self.convert_btn = Button(text="Convert")
        self.convert_btn.bind(on_press=self.do_convert)
        self.add_widget(self.convert_btn)

        self.result_label = Label(text="Result will appear here")
        self.add_widget(self.result_label)

    def do_convert(self, instance):
        try:
            number = self.input_number.text
            from_base = int(self.from_base.text)
            to_base = int(self.to_base.text)
            result = convert(number, from_base, to_base)
            self.result_label.text = f"Result: {result}"
        except Exception as e:
            self.result_label.text = f"Error: {e}"


class ConverterApp(App):
    def build(self):
        return ConverterUI()


if __name__ == "__main__":
    ConverterApp().run()
