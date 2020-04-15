import { LightningElement, track, api, wire } from 'lwc';
import getCovidData from '@salesforce/apexContinuation/Covid19TrackerController.getCov19Data';
// import WechatPublicLogo_1 from '@salesforce/resourceUrl/WechatPublicLogo_1';

// Summary Table columns
const columns = [
    {
        label: '国家',
        fieldName: 'Country',
        type: 'text',
        sortable: "true",
        cellAttributes: { class: { fieldName: 'covidStatus' } }
    }, {
        label: '新增确诊',
        fieldName: 'NewConfirmed',
        type: 'number',
        sortable: "true",
        cellAttributes: { class: { fieldName: 'covidStatus' } }
    }, {
        label: '累积确诊',
        fieldName: 'TotalConfirmed',
        type: 'number',
        sortable: "true",
        cellAttributes: { class: { fieldName: 'covidStatus' } }
    }, {
        label: '新增死亡',
        fieldName: 'NewDeaths',
        type: 'number',
        sortable: "true",
        cellAttributes: { class: { fieldName: 'covidStatus' } }
    }, {
        label: '累积死亡',
        fieldName: 'TotalDeaths',
        type: 'number',
        sortable: "true",
        cellAttributes: { class: { fieldName: 'covidStatus' } }
    }, {
        label: '新增治愈',
        fieldName: 'NewRecovered',
        type: 'number',
        sortable: "true",
        cellAttributes: { class: { fieldName: 'covidStatus' } }
    }, {
        label: '累积治愈',
        fieldName: 'TotalRecovered',
        type: 'number',
        sortable: "true",
        cellAttributes: { class: { fieldName: 'covidStatus' } }
    }
];

export default class Covid19TrackerCompt extends LightningElement {
    // Expose the static resource URL for use in the template
    // FooterLogoUrl = WechatPublicLogo_1;

    @track data = [];
    @track showSpinner = true;
    @track Initialized = false;
    @track columns = columns;
    @track sortDirection;
    @track sortBy;

    //connectedCallback() { }
    renderedCallback() {
        console.log('enter renderedCallback');

        getCovidData().then(data => {
            if (this.Initialized) {
                return;
            }
            this.Initialized = true;

            console.log('***getCovidData1.0 **');
            console.log(data.Global);
            this.data = [];
            for (let i = 0; i < data.Countries.length; i++) {
                let covidStatusVal = 'slds-text-color_success';
                if (data.Countries[i].TotalDeaths > 0) {
                    covidStatusVal = 'slds-text-color_error'; //error color code to display if total deaths > 0
                }

                var row = {
                    id: data.Countries[i].Country,
                    Country: data.Countries[i].Country,
                    NewConfirmed: data.Countries[i].NewConfirmed,
                    TotalConfirmed: data.Countries[i].TotalConfirmed,
                    NewDeaths: data.Countries[i].NewDeaths,
                    TotalDeaths: data.Countries[i].TotalDeaths,
                    NewRecovered: data.Countries[i].NewRecovered,
                    TotalRecovered: data.Countries[i].TotalRecovered,
                    covidStatus: covidStatusVal
                }
                //console.log(row);
                this.data.push(row);
            }
            console.log('Done');
            this.showSpinner = false;
            this.sortData('NewConfirmed', 'desc');

        }).catch(error => {
            console.log(' ** error ** ');
            console.log(error);
        });
    }


    //sorting methods
    handleSortdata(event) {
        this.showSpinner = true;
        // field name
        this.sortBy = event.detail.fieldName;
        // sort direction
        this.sortDirection = event.detail.sortDirection;
        console.log('fieldName : '+event.detail.fieldName + ' sortDirection : ' + event.detail.sortDirection);
        // calling sortdata function to sort the data based on direction and selected field
        this.sortData(event.detail.fieldName, event.detail.sortDirection);
    }

    sortData(fieldname, direction) {
        // serialize the data before calling sort function
        let parseData =  JSON.parse(JSON.stringify(this.data));
        // Return the value stored in the field
        let keyValue = (a) => {
            return a[fieldname];
        };
        // cheking reverse direction 
        let isReverse = direction === 'asc' ? 1 : -1;
        // sorting data 
        parseData.sort((x, y) => {
            x = keyValue(x) ? keyValue(x) : ''; // handling null values
            y = keyValue(y) ? keyValue(y) : '';

            // sorting values based on direction
            return isReverse * ((x > y) - (y > x));
        });
        // set the sorted data to data table data
        this.data = parseData;
        this.showSpinner = false;
    }
}