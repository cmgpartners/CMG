//using CMG.Application.Command;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using CMG.DataAccess.Respository;
using CMG.DataAccess.Interface;
using CMG.Application.ViewModel;
using AutoMapper;
using System.Collections.ObjectModel;
using CMG.DataAccess.Query;
using CMG.Common;

namespace CMG.UI
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public readonly IMapper _mapper;
        public readonly ICommissionRepository _commissionRepository;
        public readonly IUnitOfWork _unitOfWork;

        public ObservableCollection<string> menuItems { get; set; }

        public ObservableCollection<PersonViewModel> PersonList { get; set; }

        public int[] years { get; set; }
        public MainWindow(IUnitOfWork unitOfWork, IMapper mapper)
        {
            _unitOfWork = unitOfWork;
            _mapper = mapper;

            DataContext = this;
            InitializeComponent();
            InitializeData();

            GetCommissions();
            //GetFilteredCommission();
        }

        public void GetCommissions()
        {
            CommissionViewModel commissionViewModel = new CommissionViewModel(_unitOfWork, _mapper);
            commissionViewModel.GetAllCommission();
            var dataCollection = commissionViewModel.DataCollection;
        }

        public void GetFilteredCommission()
        {
            SearchViewModel searchViewModel = new SearchViewModel(_unitOfWork, _mapper);
            SearchQuery searchQuery = new SearchQuery();
            FilterBy filterBy = new FilterBy();
            filterBy.Property = "PolicyNumber";
            filterBy.Contains = "N059645T";
            searchQuery.FilterBy.Add(filterBy);

            filterBy = new FilterBy();
            filterBy.Property = "FYC";
            filterBy.Equal = "F";
            searchQuery.FilterBy.Add(filterBy);

            searchViewModel.GetSearchByRecords(searchQuery);
            var dataCollection = searchViewModel.DataCollection;
        }

        private void btnShutDown_Click(object sender, RoutedEventArgs e)
        {
            System.Windows.Application.Current.Shutdown(99);
        }

        private void InitializeData()
        {
            menuItems = new ObservableCollection<string>();
            for(int i = 0; i < DateTimeFormatInfo.CurrentInfo.AbbreviatedMonthNames.Length - 1; i++)
            {
                menuItems.Add(DateTimeFormatInfo.CurrentInfo.AbbreviatedMonthNames[i]);
            }
            menu.ItemsSource = menuItems;
            int currentYearCount = DateTime.Now.Year - 1950;
            cmbYears.ItemsSource = Enumerable.Range(1950, currentYearCount + 1).ToArray();
            cmbYears.SelectedValue = DateTime.Now.Year;
            PersonList = GenerateData();
            Person.ItemsSource = PersonList;
        }

        private ObservableCollection<PersonViewModel> GenerateData()
        {
            ObservableCollection<PersonViewModel> personList = new ObservableCollection<PersonViewModel>();
            personList.Add(new PersonViewModel()
            {
                id = 1,
                name = "test1",
                date = DateTime.Now.AddDays(-200)
            });

            personList.Add(new PersonViewModel()
            {
                id = 2,
                name = "test2",
                date = DateTime.Now.AddDays(-220)
            });

            personList.Add(new PersonViewModel()
            {
                id = 3,
                name = "test3",
                date = DateTime.Now.AddDays(-250)
            });
            return personList;
        }
    }

    public class PersonViewModel
    {
        public int id { get; set; }
        public string name { get; set; }

        public DateTime date { get; set; }
    }
}
