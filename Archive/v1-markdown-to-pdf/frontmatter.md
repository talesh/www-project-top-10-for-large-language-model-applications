---
pdf_options:
  format: a4
  margin: 17mm 0mm 20mm 0mm
  printBackground: true
  headerTemplate: |-
    <style>
      @media print {
        -webkit-print-color-adjust: exact;
        print-color-adjust: exact;
      }
      section {
        -webkit-print-color-adjust: exact;
        print-color-adjust: exact;
        background-color: black;
        color: white;
        margin: 0;
        margin-top: -20px;
        font-family: system-ui;
        font-size: 15px;
        padding: 0;
        padding-top: 20px;
        padding-left: 20px;
        width: 100%;
        height: 45px;
        display: block;
      }
      .header-content {
        padding-left: 10px;
        padding-bottom: -10px;
      }
      .header-logo {
        vertical-align: middle;
        height: 30px;
      }
      .title,
      .header-title {
        color: #FFF;
        vertical-align: middle;
        font-weight: bold;
      }
      .header-pipe {
        color: #D9D9D9;
        margin: 0 10px;
        vertical-align: middle;
      }
      .spacer-div {
        height: 100px;
        -webkit-print-color-adjust: exact;
        print-color-adjust: exact;
        display: block;
        margin: 0;
      }
    </style>
    <section>
      <div class="header-content">
        <span class="header-pipe">|</span>
        <span class="title"></span>
      </div>
    </section>
  footerTemplate: |-
    <style>
      footer {
        margin: 0;
        margin-left: 30px;
        font-family: system-ui;
        font-size: 11px;
        text-align: center;
        padding: 10px;
        border-top: 2px solid #D9D9D9;
        color: #8E8E8E;
        font-size: 11px;
        position: relative;
        width: 90%;
        height: 25px;
      }
      .left-text {
        position: absolute;
        top: 10px;
        left: 10px;
        bottom: 10px;
      }
      .right-text {
        position: absolute;
        top: 10px;
        right: 10px;
        bottom: 10px;
      }
    </style>
    <footer>
      <div class="left-text">
        <span>genai.owasp.org</span>
      </div>
      <div class="right-text">
        <span class="pageNumber"></span>
      </div>
    </footer>
---
