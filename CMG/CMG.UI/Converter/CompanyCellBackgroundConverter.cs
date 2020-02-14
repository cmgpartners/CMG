using System;
using System.Collections.Generic;
using System.Globalization;
using System.Text;
using System.Windows;
using System.Windows.Data;
using System.Windows.Media;

namespace CMG.UI.Converter
{
    public class CompanyCellBackgroundConverter : IValueConverter
    {


        public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            string input = (string)value;
            switch (input)
            {
                case "Sun Life":
                    return Brushes.LightGreen;
                case "London Life":
                    return Brushes.LightBlue;
                case "Great West Life":
                    return Brushes.PeachPuff;
                case "Manulife":
                    return (SolidColorBrush)(new BrushConverter().ConvertFrom("#FFF0C6FF"));
                default:
                    return default;
            }
        }

        public object ConvertBack(object value, Type targetType, object parameter, CultureInfo culture)
        {
            throw new NotImplementedException();
        }
    }
}
