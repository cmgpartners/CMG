using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text;
using System.Text.RegularExpressions;
using System.Windows.Data;

namespace CMG.UI.Converter
{
    public class PhoneNumberFormatConverter : IValueConverter
    {
        public object Convert(object value, Type targetType, object parameter, CultureInfo culture)
        {
            string phoneNumber = (string)value;
            string phoneFormat = "(###) ###-####";
            // remove everything except of numbers
            Regex regexObj = new Regex(@"[^\d]");
            phoneNumber = regexObj.Replace(phoneNumber, "");

            //format numbers to phone string
            if (phoneNumber.Length > 0)
            {
                phoneNumber = System.Convert.ToInt64(phoneNumber).ToString(phoneFormat);
            }
            return phoneNumber;
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
