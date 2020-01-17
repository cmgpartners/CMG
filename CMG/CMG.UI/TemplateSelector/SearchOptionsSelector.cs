using System;
using System.Collections.Generic;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using CMG.Application.DTO;

namespace CMG.UI.TemplateSelector
{
    public class SearchOptionsSelector : DataTemplateSelector
    {
        public DataTemplate CommonNameTemplate { get; set; }
        public DataTemplate LastNameTemplate { get; set; }
        public DataTemplate FirstNameTemplate { get; set; }
        public DataTemplate EntityTypeTemplate { get; set; }
        public DataTemplate PolicyNumberTemplate { get; set; }
        public DataTemplate CompanyNameTemplate { get; set; }
        public DataTemplate PolicyDateTemplate { get; set; }

        public override DataTemplate SelectTemplate(object item, DependencyObject container)
        {
            if (item == null) return null;
            FrameworkElement frameworkElement = container as FrameworkElement;
            if(frameworkElement != null)
            {
                string columnName = ((ViewSearchOptionsDto)item).ColumnName;
                if(columnName == "Common Name")
                {
                    CommonNameTemplate = frameworkElement.FindResource("commonNameTemplate") as DataTemplate;
                    return CommonNameTemplate;
                }
                else if(columnName == "Last Name")
                {
                    LastNameTemplate = frameworkElement.FindResource("lastNameTemplate") as DataTemplate;
                    return LastNameTemplate;
                }
                else if(columnName == "First Name")
                {
                    FirstNameTemplate = frameworkElement.FindResource("firstNameTemplate") as DataTemplate;
                    return FirstNameTemplate;
                }
                else if (columnName == "Entity Type")
                {
                    EntityTypeTemplate = frameworkElement.FindResource("entityTypeTemplate") as DataTemplate;
                    return EntityTypeTemplate;
                }
                else if (columnName == "Policy Number")
                {
                    PolicyNumberTemplate = frameworkElement.FindResource("policyNumberTemplate") as DataTemplate;
                    return PolicyNumberTemplate;
                }
                else if (columnName == "Company Name")
                {
                    CompanyNameTemplate = frameworkElement.FindResource("companyNameTemplate") as DataTemplate;
                    return CompanyNameTemplate;
                }
                else if (columnName == "Policy Date")
                {
                    PolicyDateTemplate = frameworkElement.FindResource("policyDateTemplate") as DataTemplate;
                    return PolicyDateTemplate;
                }
            }
            return null;
        }
    }
}
